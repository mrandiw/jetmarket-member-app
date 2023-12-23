import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/section/footer_section.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/section/product_detail.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/section/review_section.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/section/variant_section.dart';

import 'controllers/detail_product.controller.dart';
import 'section/header_section.dart';
import 'section/store_section.dart';

class DetailProductScreen extends GetView<DetailProductController> {
  const DetailProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
          onLoading: const LoadingPages(),
          onSuccess: _successPage(),
          status: controller.screenStatus.value);
    });
  }

  Scaffold _successPage() {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderSection(),
              const VariantSection(),
              const ProductDetailSection(),
              const StoreSection(),
              Gap(16.h),
              const ReviewSection(),
              Gap(36.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterSection(controller: controller),
    );
  }
}
