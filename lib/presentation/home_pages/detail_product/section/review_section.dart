import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/rating/rating_star.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
                border: Border(
                    bottom: AppStyle.borderSide, top: AppStyle.borderSide)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ulasan Produk', style: text16BlackSemiBold),
                Gap(8.h),
                Row(
                  children: [
                    Icon(Icons.star_rounded, color: kWarningColor, size: 18.r),
                    Gap(2.w),
                    Text(
                        '${controller.detailProduct?.review?.averrage ?? 0}/5.0',
                        style: text12BlackRegular),
                    Gap(4.w),
                    Text(
                        '(${controller.detailProduct?.review?.total ?? 0} Ulasan)',
                        style: text12HintRegular),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: controller.productReviewCustomer.isNotEmpty,
            child: Container(
              padding: AppStyle.paddingSide16,
              decoration:
                  BoxDecoration(border: Border(bottom: AppStyle.borderSide)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(12.h),
                  Text('Galeri Pembeli', style: text14BlackRegular),
                  Gap(8.h),
                  SizedBox(
                    height: 72.h,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) => CachedNetworkImage(
                              imageUrl: controller
                                      .productReviewCustomer[index].image ??
                                  '',
                              imageBuilder: (context, imageProvider) =>
                                  GestureDetector(
                                onTap: () =>
                                    controller.previewImage(imageProvider),
                                child: Container(
                                  height: 70.h,
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                    borderRadius: AppStyle.borderRadius8All,
                                    color: kSofterGrey,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => SizedBox(
                                height: 70.h,
                                width: 75.w,
                                child: const Center(
                                  child: CupertinoActivityIndicator(
                                      color: kSoftBlack),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 70.h,
                                width: 75.w,
                                decoration: BoxDecoration(
                                    borderRadius: AppStyle.borderRadius8All),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: AppStyle.borderRadius8All,
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
                            ),
                        separatorBuilder: (_, i) => Gap(8.w),
                        itemCount: controller.productReviewCustomer.length >= 4
                            ? 4
                            : controller.productReviewCustomer.length),
                  ),
                  Gap(16.h),
                ],
              ),
            ),
          ),
          Gap(16.h),
          Padding(
            padding: AppStyle.paddingSide16,
            child: Column(
                children: List.generate(
                    controller.productReviewCustomer.length,
                    (index) => Padding(
                          padding: AppStyle.paddingVert8,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                  imageUrl: controller
                                          .productReviewCustomer[index]
                                          .customer
                                          ?.avatar ??
                                      '',
                                  imageBuilder: (context, imageProvider) =>
                                      CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: kPrimaryColor2,
                                        backgroundImage: imageProvider,
                                      ),
                                  placeholder: (context, url) => SizedBox(
                                        height: 52.r,
                                        width: 52.r,
                                        child: const Center(
                                          child: CupertinoActivityIndicator(
                                              color: kSoftBlack),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      CircleAvatar(
                                        radius: 18.r,
                                        backgroundColor: kPrimaryColor2,
                                        child: Center(
                                          child: Icon(
                                            Icons.error,
                                            color: kPrimaryColor,
                                            size: 14.r,
                                          ),
                                        ),
                                      )),
                              Gap(8.w),
                              Expanded(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                    Text(
                                        controller.productReviewCustomer[index]
                                                .customer?.name ??
                                            '',
                                        style: text14BlackMedium),
                                    Gap(4.h),
                                    RatingStars(
                                        rating: controller
                                                .productReviewCustomer[index]
                                                .rating ??
                                            0.0),
                                    Gap(12.h),
                                    CachedNetworkImage(
                                      imageUrl: controller
                                              .productReviewCustomer[index]
                                              .image ??
                                          '',
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: 70.h,
                                        width: 75.w,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              AppStyle.borderRadius8All,
                                          color: kSofterGrey,
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) => SizedBox(
                                        height: 70.h,
                                        width: 75.w,
                                        child: const Center(
                                          child: CupertinoActivityIndicator(
                                              color: kSoftBlack),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        height: 70.h,
                                        width: 75.w,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                AppStyle.borderRadius8All),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                AppStyle.borderRadius8All,
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
                                    ),
                                    Gap(12.h),
                                    Text(
                                        controller.productReviewCustomer[index]
                                                .text ??
                                            '',
                                        style: text14HintRegular)
                                  ]))
                            ],
                          ),
                        ))),
          )
        ],
      );
    });
  }
}
