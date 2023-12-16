import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';

import 'controllers/product_bycategory.controller.dart';
import 'section/app_bar_section.dart';
import 'section/category_section.dart';
import 'section/product_section.dart';

class ProductBycategoryScreen extends GetView<ProductBycategoryController> {
  const ProductBycategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => ParentScaffold(
        onLoading: const LoadingPages(),
        onSuccess: _successPage(),
        status: controller.screenStatus.value));
  }

  Scaffold _successPage() {
    return Scaffold(
        appBar: appBarProductCategory,
        body: CustomScrollView(
          slivers: [
            const CategorySection(),
            ProductSection(controller: controller),
            SliverToBoxAdapter(
              child: Gap(22.h),
            )
          ],
        ));
  }
}
