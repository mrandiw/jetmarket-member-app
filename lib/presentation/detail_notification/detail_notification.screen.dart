import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/detail_notification/section/app_bar_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/detail_notification.controller.dart';

class DetailNotificationScreen extends GetView<DetailNotificationController> {
  const DetailNotificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: CustomScrollView(
        slivers: [
          const AppBarSection(),
          SliverPadding(
            padding: AppStyle.paddingAll16,
            sliver: SliverToBoxAdapter(
              child: Obx(
                () {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: controller.notification.image != null &&
                                controller.notification.image!.isNotEmpty
                            ? true
                            : false,
                        child: CachedNetworkImage(
                          imageUrl: controller.notification.image ?? '',
                          height: 140.w,
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: 140.w,
                              decoration: BoxDecoration(
                                  color: kSofterGrey,
                                  borderRadius: AppStyle.borderRadius8All,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            );
                          },
                          placeholder: (context, url) =>
                              const Center(child: CupertinoActivityIndicator()),
                          errorWidget: (context, url, error) {
                            return Container(
                              height: 140.w,
                              padding: EdgeInsets.all(5.w),
                              decoration: BoxDecoration(
                                color: kSofterGrey,
                                borderRadius: AppStyle.borderRadius8All,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.error,
                                  color: kPrimaryColor,
                                  size: 18.r,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.notification.title ?? '-',
                        style: GoogleFonts.poppins(
                          fontSize: 14.sp,
                          color: kBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(2.w),
                      Text('${controller.notification.body}',
                          style: text11GreyRegular),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
