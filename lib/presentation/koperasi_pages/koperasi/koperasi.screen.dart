import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'controllers/koperasi.controller.dart';
import 'section/app_bar_section.dart';
import 'section/header_section.dart';
import 'section/history_section.dart';

class KoperasiScreen extends GetView<KoperasiController> {
  const KoperasiScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarKoperasi,
        backgroundColor: kWhite,
        body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: false,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          onLoading: controller.onLoading,
          header: const WaterDropHeader(
            waterDropColor: kPrimaryColor,
            complete: SizedBox.shrink(),
            refresh: CupertinoActivityIndicator(
              color: kSoftGrey,
            ),
          ),
          child: CustomScrollView(
            slivers: [
              HeaderSection(controller: controller),
              HistorySection(controller: controller)
            ],
          ),
        ));
  }
}
