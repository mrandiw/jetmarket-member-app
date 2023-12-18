import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';
import 'package:jetmarket/presentation/home_pages/all_category/section/list_category.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/all_category.controller.dart';
import 'section/app_bar_section.dart';

class AllCategoryScreen extends GetView<AllCategoryController> {
  const AllCategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onSuccess: _successPage(),
        status: controller.screenStatus.value));
  }

  Scaffold _successPage() {
    return Scaffold(
        appBar: appBarAllCategory,
        backgroundColor: kWhite,
        body: const ListCategory());
  }
}
