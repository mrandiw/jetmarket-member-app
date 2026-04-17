#!/usr/bin/env python3
from __future__ import annotations

import re
from pathlib import Path


def replace_block(text: str, start_pat: str, end_pat: str, replacement: str) -> str:
    start = re.search(start_pat, text, flags=re.MULTILINE)
    if not start:
        raise RuntimeError(f"Start pattern not found: {start_pat}")
    end = re.search(end_pat, text[start.end():], flags=re.MULTILINE)
    if not end:
        raise RuntimeError(f"End pattern not found: {end_pat}")
    end_index = start.end() + end.start()
    return text[: start.start()] + replacement + text[end_index:]


def patch_xendit_go(xendit_path: Path) -> None:
    src = xendit_path.read_text(encoding="utf-8")
    old = """\t\t\tExpiredAt: sql.NullTime{
\t\t\t\tValid: false,
\t\t\t\tTime:  time.Time{},
\t\t\t},
"""
    new = """\t\t\tExpiredAt: sql.NullTime{
\t\t\t\tValid: true,
\t\t\t\tTime:  time.Now().Add(PaymentExpireDuration),
\t\t\t},
"""
    if old not in src:
        raise RuntimeError("Expected ExpiredAt block not found in api/xendit.go (ewallet create transaction).")
    src = src.replace(old, new, 1)
    xendit_path.write_text(src, encoding="utf-8")


def patch_saving_go(saving_path: Path) -> None:
    src = saving_path.read_text(encoding="utf-8")

    # Ensure imports include time.
    if '"time"' not in src:
        src = src.replace(
            'import (\n\t"net/http"\n\t"strings"\n',
            'import (\n\t"net/http"\n\t"strings"\n\t"time"\n',
            1,
        )

    new_func = r"""func (server *Server) GetSavingWaitingPayment(c *gin.Context) {
	authPayload := c.MustGet(authorizationPayloadKey).(*token.Payload)
	savingArg := db.ListWaitingSavingByUserIDParams{
		UserID:   authPayload.UserId,
		UserRole: authPayload.Role,
	}
	transactions, err := server.q.ListWaitingSavingByUserID(c, savingArg)
	if err != nil {
		ErrorHandler500(c, err, savingArg)
		return
	}
	if len(transactions) == 0 {
		c.JSON(http.StatusOK, Response{
			Code:    http.StatusOK,
			Message: "Tidak ada transaksi pending",
		})
		return
	}

	now := time.Now()
	for _, trx := range transactions {
		// Backward-compat: some old transactions (especially EWALLET) were created with expired_at = NULL.
		// Treat them as expired after PaymentExpireDuration to avoid trapping users on very old pending payments.
		if (!trx.ExpiredAt.Valid && now.Sub(trx.CreatedAt) > PaymentExpireDuration) ||
			(trx.ExpiredAt.Valid && trx.ExpiredAt.Time.Before(now)) {
			_, _ = server.q.UpdateTransactionStatusByPrID(c, db.UpdateTransactionStatusByPrIDParams{
				PrID:      trx.PrID,
				Status:    constants.TrxFailed,
				UpdatedAt: now,
			})
			if entry, e := server.q.GetSavingEntryByRefId(c, trx.RefID); e == nil {
				_, _ = server.q.UpdateSavingEntryStatus(c, db.UpdateSavingEntryStatusParams{
					ID:        entry.ID,
					Status:    constants.SesFailed,
					NoteTitle: "Tabungan pembayaran kadaluarsa",
					NoteBody:  "Transaksi pembayaran tabungan sudah kadaluarsa. Silakan buat pembayaran baru.",
				})
			}
			continue
		}

		resp, _, err := server.xendit.PaymentRequestApi.GetPaymentRequestByID(c, trx.PrID).Execute()
		if err != nil || resp.Id == "" {
			_, _ = server.q.UpdateTransactionStatusByPrID(c, db.UpdateTransactionStatusByPrIDParams{
				PrID:      trx.PrID,
				Status:    constants.TrxFailed,
				UpdatedAt: now,
			})
			continue
		}

		// If Xendit already finalized/expired the payment request, don't keep returning it as waiting payment.
		prStatus := resp.GetStatus().String()
		switch prStatus {
		case "PENDING", "REQUIRES_ACTION", "ACTIVE":
			// keep
		default:
			_, _ = server.q.UpdateTransactionStatusByPrID(c, db.UpdateTransactionStatusByPrIDParams{
				PrID:      trx.PrID,
				Status:    constants.TrxFailed,
				UpdatedAt: now,
			})
			if entry, e := server.q.GetSavingEntryByRefId(c, trx.RefID); e == nil {
				_, _ = server.q.UpdateSavingEntryStatus(c, db.UpdateSavingEntryStatusParams{
					ID:        entry.ID,
					Status:    constants.SesFailed,
					NoteTitle: "Tabungan pembayaran kadaluarsa",
					NoteBody:  "Transaksi pembayaran tabungan sudah kadaluarsa. Silakan buat pembayaran baru.",
				})
			}
			continue
		}

		cust, err := server.q.GetCustomer(c, trx.UserID)
		if err != nil {
			ErrorHandler500(c, err, trx.UserID)
			return
		}

		result := TransactionDetail{
			Id:          trx.ID,
			ReferenceId: trx.RefID,
			Name:        cust.Name,
			Amount:      trx.Amount,
			Phone:       cust.Phone,
			Status:      string(trx.Status),
			Channel: TransactionChannel{
				Type: trx.Type,
				Code: trx.ChannelCode,
			},
		}

		switch trx.Type {
		case "EWALLET":
			qrCode := ""
			deepLink := ""

			for _, action := range resp.Actions {
				if action.UrlType == "DEEPLINK" {
					deepLink = action.GetUrl()
					continue
				}
				if action.UrlType == "MOBILE" {
					deepLink = action.GetUrl()
					continue
				}
				if action.Action == "PRESENT_TO_CUSTOMER" {
					qrCode = action.GetQrCode()
					continue
				}
			}
			result.Ewallet = &TransactionEwallet{
				QrCode:   qrCode,
				Deeplink: deepLink,
			}

			c.JSON(http.StatusOK, ResponseData{
				Code:    http.StatusOK,
				Message: "Berhasil menampilkan Data!",
				Data:    result,
			})
			return
		case "VIRTUAL_ACCOUNT":
			vaProperties := resp.PaymentMethod.GetVirtualAccount().ChannelProperties
			result.VirtualAccount = &TransactionVirtualAccount{
				Number:    *vaProperties.VirtualAccountNumber,
				Name:      vaProperties.CustomerName,
				ExpiredAt: vaProperties.ExpiresAt.Format(constants.DateFormat),
			}

			c.JSON(http.StatusOK, ResponseData{
				Code:    http.StatusOK,
				Message: "Berhasil menampilkan Data!",
				Data:    result,
			})
			return
		case "QR_CODE":
			qrCodeProperties := resp.PaymentMethod.GetQrCode().ChannelProperties
			result.QrCode = &TransactionQrCode{
				Code:      *qrCodeProperties.QrString,
				ExpiredAt: qrCodeProperties.ExpiresAt.Format(constants.DateFormat),
			}

			c.JSON(http.StatusOK, ResponseData{
				Code:    http.StatusOK,
				Message: "Berhasil menampilkan Data!",
				Data:    result,
			})
			return
		case "OTC":
			otcProperties := resp.PaymentMethod.GetOverTheCounter().ChannelProperties
			result.Otc = &TransactionOtc{
				Code:      *otcProperties.PaymentCode,
				Name:      otcProperties.CustomerName,
				ExpiredAt: otcProperties.ExpiresAt.Format(constants.DateFormat),
			}

			c.JSON(http.StatusOK, ResponseData{
				Code:    http.StatusOK,
				Message: "Berhasil menampilkan Data!",
				Data:    result,
			})
			return
		}
	}

	c.JSON(http.StatusOK, Response{
		Code:    http.StatusOK,
		Message: "Tidak ada transaksi pending",
	})
}

"""

    src = replace_block(
        src,
        start_pat=r"^func \(server \*Server\) GetSavingWaitingPayment\(c \*gin\.Context\) \{",
        end_pat=r"^func \(server \*Server\) GetSavingListAdmin\(c \*gin\.Context, params GetSavingListAdminParams\) \{",
        replacement=new_func
        + "func (server *Server) GetSavingListAdmin(c *gin.Context, params GetSavingListAdminParams) {",
    )

    saving_path.write_text(src, encoding="utf-8")


def main() -> None:
    server_root = Path("/Users/admin/Desktop/armada/jetmarket/jetmarket-server")
    xendit_path = server_root / "api" / "xendit.go"
    saving_path = server_root / "api" / "saving.go"

    if not xendit_path.exists():
        raise SystemExit(f"Not found: {xendit_path}")
    if not saving_path.exists():
        raise SystemExit(f"Not found: {saving_path}")

    patch_xendit_go(xendit_path)
    patch_saving_go(saving_path)
    print("Patched:", xendit_path)
    print("Patched:", saving_path)


if __name__ == "__main__":
    main()
