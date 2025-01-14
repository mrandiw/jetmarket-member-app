import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/app_bar_section.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/info_delivery.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/detail_order.controller.dart';
import 'section/detail_product.dart';
import 'section/footer_section.dart';
import 'section/payment_methode.dart';
import 'widget/info_order.dart';

class DetailOrderScreen extends GetView<DetailOrderController> {
  const DetailOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Widget successWidget(DetailOrderController controller) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        controller.backToOrder();
        return true;
      },
      child: Scaffold(
        appBar: appBarDetailOrder(controller),
        body: ListView(
          children: [
            InfoOrder(
              type: controller.typeStatus(controller.statusOrder),
            ),
            InfoDelivery(controller: controller),
            DetailProduct(controller: controller),
            PaymentMethode(controller: controller),
            if (controller.detailOrderCustomer?.status?.contains('CANCELLED') ??
                false)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Alasan Pembatalan', style: text14BlackMedium),
                      Text(
                        controller.detailOrderCustomer?.reason ?? '-',
                        style: text14BlackRegular,
                      )
                    ]),
              )
          ],
        ),
        bottomNavigationBar: FooterSection(
          controller: controller,
        ),
      ),
    );
  }
}
