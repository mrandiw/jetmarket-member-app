import 'package:flutter/material.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/account_pages/review_product/controllers/review_product.controller.dart';
import '../../../../infrastructure/theme/app_text.dart';

class AppBarReviewProduct extends StatelessWidget {
  final TabController tabController;
  final ReviewProductController controller;
  final bool isScroll;

  const AppBarReviewProduct({
    super.key,
    required this.tabController,
    required this.controller,
    required this.isScroll,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      backgroundColor: kWhite,
      forceElevated: isScroll,
      title: Text('Review', style: text16BlackSemiBold),
      bottom: TabBar(
        controller: tabController,
        labelStyle: text12PrimarySemiBold,
        indicatorColor: kSecondaryColor,
        labelColor: kSecondaryColor,
        unselectedLabelColor: kSofterGrey,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: controller.statusTabs.map((e) {
          return Tab(
            text: e['name'],
          );
        }).toList(),
      ),
    );
  }
}
