import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/detail_order/section/app_bar_section.dart';
import 'package:jetmarket/presentation/detail_order/section/info_delivery.dart';

import 'controllers/detail_order.controller.dart';
import 'section/detail_product.dart';
import 'section/footer_section.dart';
import 'section/payment_methode.dart';
import 'widget/info_order.dart';

class DetailOrderScreen extends GetView<DetailOrderController> {
  const DetailOrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDetailOrder,
      body: ListView(
        children: [
          InfoOrder(
            status: controller.statusOrder,
          ),
          const InfoDelivery(),
          const DetailProduct(),
          const PaymentMethode()
        ],
      ),
      bottomNavigationBar: FooterSection(
        controller: controller,
      ),
    );
  }
}
