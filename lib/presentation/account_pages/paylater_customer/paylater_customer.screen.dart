import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/paylater_customer.controller.dart';
import 'section/app_bar_section.dart';
import 'section/paylater_section.dart';

class PaylaterCustomerScreen extends GetView<PaylaterCustomerController> {
  const PaylaterCustomerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Scaffold successWidget() {
    return Scaffold(
      appBar: appBarPaylaterCustomer,
      body: const PaylaterSection(),
    );
  }
}
