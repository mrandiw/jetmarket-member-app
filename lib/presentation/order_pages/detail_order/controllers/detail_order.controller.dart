import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/domain/core/interfaces/order_repository.dart';
import 'package:jetmarket/presentation/main_pages/controllers/main_pages.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../domain/core/model/model_data/detail_order_customer.dart';
import '../../../../infrastructure/dal/repository/notification_repository_impl.dart';
import '../../../../infrastructure/dal/services/firebase/firebase_controller.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';
import '../../order/controllers/order.controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DetailOrderController extends GetxController {
  final OrderRepository _orderRepository;

  DetailOrderController(this._orderRepository);

  DetailOrderCustomer? detailOrderCustomer;

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = ActionStatus.initalize;
  String statusOrder = "";
  String? argumentBack;
  int totalPrice = 0;
  bool onDelivery = false;

  Future<void> getDetailOrder() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.getDetailOrder(
        Get.arguments[0], Get.arguments[3]);
    if (response.status == StatusResponse.success) {
      detailOrderCustomer = response.result;
      statusOrder = detailOrderCustomer?.status ?? '';
      log(detailOrderCustomer?.toJson().toString() ?? '');
      countTotalPrice();
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  int typeStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
      case "WAITING_CUSTOMER_CONFIRMATION":
        return 1;
      case 'FINISHED':
      case 'REVIEWED':
        return 2;
      case "PENDING":
      case "WAITING_DELIVERY":
      case "WAITING_PAYMENT":
      case "WAITING_SELLER_CONFIRMATION":
        return 3;
      case "REQUEST_REFUND_CUSTOMER":
      case "REFUNDED":
        return 4;
      default:
        return 0;
    }
  }

  String convertTypeStatus(String status) {
    switch (status) {
      case "ON_DELIVERY":
        return 'Dalam Pengiriman';
      case "WAITING_CUSTOMER_CONFIRMATION":
        return 'Sampai Tujuan';
      case 'FINISHED':
      case 'REVIEWED':
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
        return 'Permintaan Pengembalian Dana';
      default:
        return 'Refunded';
    }
  }

  void countTotalPrice() {
    totalPrice = 0;
    for (Products item in detailOrderCustomer?.products ?? []) {
      totalPrice += (item.price ?? 0 * item.quantity!);
    }
  }

  void toComplain() {
    Get.toNamed(Routes.KOMPLAIN, arguments: detailOrderCustomer?.id);
  }

  void confirmOrder() {
    AppDialogConfirmation.show(
        title: 'Konfirmasi Pesanan',
        message:
            'Pastikan pesananmu aman dan sesuai sebelum melakukan konfirmasi pesanan.',
        onTesText: 'Sesuai',
        onPressed: () => receiveOrder());
  }

  Future<void> receiveOrder() async {
    Get.back();
    actionButton = ActionStatus.loading;
    update();
    final response =
        await _orderRepository.receiveOrder(detailOrderCustomer?.id ?? 0);
    if (response.status == StatusResponse.success) {
      actionButton = ActionStatus.success;
      update();
      Get.toNamed(Routes.REVIEW_ORDER,
          arguments: [detailOrderCustomer?.id ?? 0, 'receive-review']);
    } else {
      actionButton = ActionStatus.failed;
      update();
    }
  }

  void backToOrder() {
    // Get.back();

    if (Get.arguments[2] != null) {
      updateUnreadNotification();
      Get.offAllNamed(Routes.MAIN_PAGES);
      Get.put(MainPagesController());
    } else {
      if (argumentBack != null) {
        if (argumentBack == 'review') {
          Get.back();
          refreshOrder();
        } else if (argumentBack == '') {
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  Future<void> updateUnreadNotification() async {
    final controller =
        Get.put(FirebaseController(NotificationRepositoryImpl()));
    await controller.getUnreadNotification();
  }

  void toTracking(int id, String status) {
    if (status == 'ON_DELIVERY') {
      Get.toNamed(Routes.TRACKING_ORDER, arguments: id);
    } else {
      Get.toNamed(Routes.TRACKING_RETURN, arguments: id);
    }
  }

  void refreshOrder() {
    final controller = Get.find<OrderController>();
    controller.pagingController.refresh();
  }

  setArgument() {
    if (Get.arguments[1] != null) {
      argumentBack = Get.arguments[1];
    }
  }

  void copyAddress(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
    Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
      backgroundColor: kBlack,
      duration: 2.seconds,
      borderRadius: 8.r,
      messageText: Text(
        'Alamat berhasil disalin',
        style: text12WhiteRegular,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Future<File> generateInvoicePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Expanded(
                    child: pw.Text(
                      'Jetmarket',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(
                        'Invoice',
                        style: pw.TextStyle(
                          fontSize: 20,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      // pw.Text(
                      //   detailOrderCustomer?.refId ?? '-',
                      //   style: const pw.TextStyle(fontSize: 12),
                      // ),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'Diterbitkan atas nama'.toUpperCase(),
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Pembeli: ${detailOrderCustomer?.customerName ?? ''}',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text(
                  'Waktu Pemesanan: ${detailOrderCustomer!.createdAt != null && detailOrderCustomer?.createdAt != null ? detailOrderCustomer?.createdAt : '-'}',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text(
                  'Waktu Pembayaran: ${detailOrderCustomer!.paymentMethod != null && detailOrderCustomer?.paymentMethod!.createdAt != null ? detailOrderCustomer?.paymentMethod!.createdAt : '-'}',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.SizedBox(height: 20),
              pw.Text(
                'Info Pengiriman'.toUpperCase(),
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.Text(
                  '${detailOrderCustomer?.delivery?.serviceCode} - ${detailOrderCustomer?.delivery?.serviceName}',
                  style: const pw.TextStyle(fontSize: 14)),
              pw.Text(
                'Alamat Pengiriman: ${detailOrderCustomer?.address?.address}',
                style: const pw.TextStyle(fontSize: 12),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(children: [
                    pw.Text('INFO PRODUK',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('JUMLAH',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text('HARGA',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ]),
                  ...List.generate(
                    detailOrderCustomer?.products?.length ?? 0,
                    (index) {
                      final obj = detailOrderCustomer?.products?[index];
                      return pw.TableRow(
                        children: [
                          pw.Text(obj?.name ?? ''),
                          pw.Text((obj?.quantity ?? 0).toString()),
                          pw.Text(((obj?.price ?? 0) * (obj?.quantity ?? 0))
                              .toString()),
                        ],
                      );
                    },
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                  'SUBTOTAL HARGA: ${(detailOrderCustomer?.totalAmount ?? 0).toString().toIdrFormat}',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.Text(
                  'Kupon Diskon: -${(detailOrderCustomer?.totalDiscount ?? 0).toString().toIdrFormat}',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.Text(
                  'Total Ongkos Kirim: ${(detailOrderCustomer?.totalOngkir ?? 0).toString().toIdrFormat}',
                  style: const pw.TextStyle(fontSize: 12)),
              pw.SizedBox(height: 20),
              pw.Text(
                'TOTAL TAGIHAN: ${(detailOrderCustomer?.totalPrice ?? 0)}',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.Divider(),
              pw.Text(
                'Metode Pembayaran: ${(detailOrderCustomer?.paymentMethod?.chType ?? '')} - ${detailOrderCustomer?.paymentMethod?.chCode}',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  @override
  void onInit() {
    setArgument();
    getDetailOrder();
    super.onInit();
  }
}
