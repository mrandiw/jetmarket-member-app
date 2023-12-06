import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/auth/payment_status/section/on_proccess_section.dart';
import 'package:jetmarket/presentation/auth/payment_status/section/success_section.dart';

import 'controllers/payment_status.controller.dart';

class PaymentStatusScreen extends GetView<PaymentStatusController> {
  const PaymentStatusScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteBackground,
        body: FutureBuilder(
            future: controller.checkStatus(),
            builder: (_, snap) {
              return SizedBox(child: Obx(() {
                if (controller.statusPayment.value) {
                  return const SuccessSection();
                } else {
                  return const OnProccessSection();
                }
              }));
            }));
  }
}
