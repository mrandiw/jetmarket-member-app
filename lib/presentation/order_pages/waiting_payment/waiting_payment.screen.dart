import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/waiting_payment/section/app_bar_section.dart';
import 'package:jetmarket/presentation/order_pages/waiting_payment/section/order_list.dart';

import 'controllers/waiting_payment.controller.dart';

class WaitingPaymentScreen extends GetView<WaitingPaymentController> {
  const WaitingPaymentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarWaitingPayment, body: const OrderList());
  }
}
