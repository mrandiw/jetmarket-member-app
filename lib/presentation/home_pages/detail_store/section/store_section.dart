import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({super.key, required this.controller});
  final DetailStoreController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: AppStyle.borderRadius8All,
            color: kWhite,
            border: AppStyle.borderAll,
            boxShadow: [AppStyle.boxShadowSmall]),
        child: Column(
          children: [
            ListTile(
              contentPadding: AppStyle.paddingAll8,
              leading: CachedNetworkImage(
                  imageUrl: controller.detailShop?.avatar ?? '',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 26.r,
                        backgroundColor: kPrimaryColor2,
                        backgroundImage: imageProvider,
                      ),
                  placeholder: (context, url) => SizedBox(
                        height: 72.r,
                        width: 72.r,
                        child: const Center(
                          child: CupertinoActivityIndicator(color: kSoftBlack),
                        ),
                      ),
                  errorWidget: (context, url, error) => CircleAvatar(
                        radius: 26.r,
                        backgroundColor: kPrimaryColor2,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: kPrimaryColor,
                            size: 20.r,
                          ),
                        ),
                      )),
              title: Text(controller.detailShop?.name ?? '',
                  style: text14BlackMedium),
              trailing: SizedBox(
                width: 90.wr,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.star_rounded,
                            color: kWarningColor, size: 16.hr),
                        Gap(2.wr),
                        Text("${controller.detailShop?.rating ?? 0}",
                            style: text12BlackSemiBold)
                      ],
                    ),
                    Text('Rating & Ulasan', style: text10HintRegular)
                  ],
                ),
              ),
            ),
            Divider(
              color: kBorder,
              height: 0,
              thickness: 1,
            ),
            Gap(12.h),
            Padding(
              padding: AppStyle.paddingSide12,
              child: Row(
                children: [
                  SvgPicture.asset(pinMapLine),
                  Gap(8.w),
                  Expanded(
                    child: Text(controller.detailShop?.address ?? '',
                        style: text11GreyRegular),
                  ),
                  Gap(8.w),
                  GestureDetector(
                      onTap: () => controller.onTapLocationStore(),
                      child: SvgPicture.asset(editLine))
                ],
              ),
            ),
            Gap(16.h),
          ],
        ),
      ),
    );
  }
}
