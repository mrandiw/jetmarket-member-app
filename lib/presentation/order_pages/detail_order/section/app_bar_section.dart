import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/invoice_preview.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar appBarDetailOrder(DetailOrderController controller) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => controller.backToOrder(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Detail Order', style: text16BlackSemiBold),
    actions: [
      if (!(controller.detailOrderCustomer?.status?.startsWith('CANCELLED') ??
          false))
        IconButton(
          onPressed: () async {
            final file = await controller.generateInvoicePdf();

            Get.to(() => InvoicePreview(file: file));
          },
          icon: const Icon(
            Icons.print,
            color: Colors.black,
          ),
        )
    ],
  );
}
