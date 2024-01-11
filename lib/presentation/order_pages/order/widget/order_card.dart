import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import '../../../../components/button/app_button.dart';
import '../../../../domain/core/model/model_data/order_product_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      required this.data,
      required this.status,
      this.onTap,
      this.actionOrder,
      this.tracking});

  final OrderProductModel data;
  final String status;
  final Function()? onTap;
  final Function()? actionOrder;
  final Function()? tracking;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: AppStyle.paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(convertTypeStatus(data.status ?? ''),
                        style: textStatusStyle(data.status ?? '')),
                    Visibility(
                      visible: data.status == 'ON_DELIVERY',
                      child: GestureDetector(
                          onTap: tracking,
                          child: Text('Lacak', style: text12SucessRegular)),
                    ),
                  ],
                )),
            Divider(height: 0, thickness: 1, color: kBorder),
            Padding(
              padding: AppStyle.paddingAll12,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: Uri.tryParse(data.image ?? '')?.isAbsolute == true
                        ? data.image ?? ''
                        : '',
                    height: 50.r,
                    width: 50.r,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 120.w,
                        decoration: BoxDecoration(
                            color: kSofterGrey,
                            borderRadius: AppStyle.borderRadius8All,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover)),
                      );
                    },
                    placeholder: (context, url) =>
                        const Center(child: CupertinoActivityIndicator()),
                    errorWidget: (context, url, error) {
                      return Container(
                        height: 50.r,
                        width: 50.r,
                        padding: EdgeInsets.all(5.w),
                        decoration: BoxDecoration(
                          color: kSofterGrey,
                          borderRadius: AppStyle.borderRadius8All,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: kPrimaryColor,
                            size: 18.r,
                          ),
                        ),
                      );
                    },
                  ),
                  Gap(8.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.name ?? '', style: text12BlackSemiBold),
                        Gap(6.h),
                        Row(
                          children: [
                            Text('${data.price}'.toIdrFormat,
                                style: text12BlackRegular),
                            // Gap(8.w),
                            // Text('50000', style: text14lineThroughRegular),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Center(
                child: Text(
              'Lihat ${data.totalProduct} produk lainnya',
              style: text12HintRegular,
            )),
            Gap(12.h),
            Divider(height: 0, thickness: 1, color: kBorder),
            Visibility(
              visible: status == 'packaging' || status == 'on_delivery',
              child: Padding(
                padding: AppStyle.paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total bayar', style: text12BlackRegular),
                    Text('${data.totalPrice}'.toIdrFormat,
                        style: text12PrimaryMedium)
                  ],
                ),
              ),
            ),
            Visibility(
              visible: status != 'packaging' && status != 'on_delivery',
              child: Padding(
                padding: AppStyle.paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            status == 'refunded'
                                ? 'Jumlah Dana'
                                : 'Total bayar',
                            style: text12BlackRegular),
                        Text('${data.totalPrice}'.toIdrFormat,
                            style: text12PrimaryMedium)
                      ],
                    ),
                    AppButton.primarySmall(
                      text: data.status == 'REFUNDED' ||
                              data.status == "REQUEST_REFUND_CUSTOMER"
                          ? 'Rincian Pengembalian'
                          : data.status == 'WAITING_REFUND_DELIVERY'
                              ? 'Atur Pengembalian'
                              : data.status == 'REFUND_ON_DELIVERY'
                                  ? 'Lihat Pengembalian'
                                  : data.status == 'FINISHED'
                                      ? 'Review'
                                      : 'Beli Lagi',
                      onPressed: actionOrder,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStatusStyle(String status) {
    if (status == "ON_DELIVERY") {
      return text12NormalRegular;
    } else if (status == "WAITING_CUSTOMER_CONFIRMATION") {
      return text12NormalAccentRegular;
    } else if (status == 'FINISHED' || status == "REFUND_ON_DELIVERY") {
      return text12SucessRegular;
    } else if (status == "PENDING" ||
        status == "WAITING_DELIVERY" ||
        status == "WAITING_PAYMENT" ||
        status == "WAITING_SELLER_CONFIRMATION" ||
        status == "REQUEST_REFUND_CUSTOMER" ||
        status == "WAITING_REFUND_DELIVERY") {
      return text12WarningMedium;
    } else if (status == "CANCELLED_BY_COURIER" ||
        status == "CANCELLED_BY_SELLER" ||
        status == "CANCELLED_BY_SYSTEM" ||
        status == "CANCELLED_BY_CUSTOMER" ||
        status == "REFUNDED") {
      return text12PrimaryRegular;
    } else {
      return text12HintRegular;
    }
  }

  String convertTypeStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
        return 'Dalam Pengiriman';
      case "WAITING_CUSTOMER_CONFIRMATION":
        return 'Sampai Tujuan';
      case 'FINISHED':
        return 'Selesai';
      case "WAITING_DELIVERY":
        return 'Menunggu Pengiriman';
      case "WAITING_PAYMENT":
        return 'Menunggu Pembayaran';
      case "WAITING_SELLER_CONFIRMATION":
        return 'Menunggu Konfirmasi Penjual';
      case "CANCELLED_BY_COURIER":
        return 'Dibatalkan Oleh Kurir';
      case "CANCELLED_BY_SELLER":
        return 'Dibatalkan Oleh Penjual';
      case "CANCELLED_BY_SYSTEM":
        return 'Dibatalkan Oleh System';
      case "CANCELLED_BY_CUSTOMER":
        return 'Dibatalkan Oleh Anda';
      case "REQUEST_REFUND_CUSTOMER":
        return 'Permintaan Pengembalian Customer';
      case "REFUND_ON_DELIVERY":
        return 'Sedang dikirim ke alamat pengembalian';
      case "WAITING_REFUND_DELIVERY":
        return 'Menunggu Pengembalian Barang';
      default:
        return 'Pengembalian Barang & Dana Selesai';
    }
  }
}
