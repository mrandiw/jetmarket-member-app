import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/detail_return/section/detail_refund_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/detail_return.controller.dart';
import 'section/app_bar_section.dart';
import 'section/status_section.dart';

class DetailReturnScreen extends GetView<DetailReturnController> {
  const DetailReturnScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarDetailKomplain,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: [
            StatusSection(controller: controller),
            DetailRefundSection(controller: controller)
          ],
        ));
  }
}
