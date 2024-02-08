import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import 'store_section.dart';

class AppBarDetailStore extends StatelessWidget {
  final TabController tabController;
  final DetailStoreController controller;
  final bool isScroll;

  const AppBarDetailStore({
    Key? key,
    required this.tabController,
    required this.controller,
    required this.isScroll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: 0,
      backgroundColor: kWhite,
      surfaceTintColor: kWhite,
      automaticallyImplyLeading: false,
      expandedHeight: 246.hr,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          children: [
            Container(
              color: kWhite,
              padding: EdgeInsets.symmetric(vertical: 3.hr),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(arrowForward),
                  ),
                  Gap(12.w),
                  Text('Detail Store', style: text16BlackSemiBold),
                ],
              ),
            ),
            Divider(
              color: kBorder,
              height: 0,
              thickness: 1,
            ),
            Gap(4.h),
            StoreSection(
              controller: controller,
            )
          ],
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: kWhite,
            border: Border(bottom: BorderSide(color: kDivider)),
          ),
          child: Obx(() {
            return TabBar(
              controller: tabController,
              labelStyle: text14PrimarySemiBold,
              indicatorColor: kSecondaryColor,
              labelColor: kSecondaryColor,
              unselectedLabelColor: kBorder,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: controller.tabs.map((e) {
                bool isActive = controller.tabs.indexOf(e) ==
                    controller.currentIndexTab.value;
                return Padding(
                  padding: AppStyle.paddingVert12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(e == 'Produk' ? produk : kategori,
                          colorFilter: ColorFilter.mode(
                              isActive ? kSecondaryColor : kBorder,
                              BlendMode.srcIn)),
                      Gap(8.w),
                      Text(e),
                    ],
                  ),
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
