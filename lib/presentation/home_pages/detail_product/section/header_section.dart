import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return SizedBox(
        height: 250.hr,
        width: Get.width.wr,
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              height: 250.hr,
              width: Get.width.wr,
              color: kWhite,
              child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: (value) => controller.onImageSlide(value),
                  itemCount: controller.detailProduct?.images?.length,
                  itemBuilder: (_, index) {
                    return CachedNetworkImage(
                      imageUrl: controller.detailProduct?.images?[index] ?? '',
                      imageBuilder: (context, imageProvider) => Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius8Top,
                          color: kSofterGrey,
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => SizedBox(
                        height: 92.h,
                        width: Get.width,
                        child: const Center(
                          child: CupertinoActivityIndicator(color: kSoftBlack),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 92.h,
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8Top),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius8Top,
                            color: kSofterGrey,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.error,
                              color: kPrimaryColor,
                              size: 20.r,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            )),
            Positioned(
                top: 16.h,
                right: 16.w,
                left: 16.w,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(
                        arrowForward,
                        colorFilter:
                            const ColorFilter.mode(kBlack, BlendMode.srcIn),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 34.hr,
                        width: 34.hr,
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius6All,
                            color: kSofterGrey),
                        child: Center(
                          child: SvgPicture.asset(
                            cartLine,
                            colorFilter:
                                const ColorFilter.mode(kBlack, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    ),
                    Gap(12.w),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 34.r,
                        width: 34.r,
                        decoration: BoxDecoration(
                            borderRadius: AppStyle.borderRadius6All,
                            color: kSofterGrey),
                        child: Center(
                          child: SvgPicture.asset(
                            shareLine,
                            colorFilter:
                                const ColorFilter.mode(kBlack, BlendMode.srcIn),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Positioned(
                left: 16.w,
                bottom: 16.h,
                child: Container(
                  height: 22.h,
                  width: 38.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26.r), color: kWhite),
                  child: Center(
                      child: Text(
                          '${controller.currentIndexImage + 1}/${controller.detailProduct?.images?.length ?? 1}',
                          style: text12BlackRegular)),
                ))
          ],
        ),
      );
    });
  }
}
