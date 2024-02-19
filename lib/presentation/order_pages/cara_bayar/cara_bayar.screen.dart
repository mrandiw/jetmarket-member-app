import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/cara_bayar/section/app_bar_section.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/cara_bayar.controller.dart';
import 'section/detail_section.dart';

class CaraBayarScreen extends GetView<CaraBayarController> {
  const CaraBayarScreen({super.key});
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

  Widget successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: appBarCaraBayar,
      body: const SafeArea(
        child: DetailSection(),
      ),
    );
  }
}
