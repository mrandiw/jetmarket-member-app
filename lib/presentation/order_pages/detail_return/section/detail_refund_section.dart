import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';
import '../controllers/detail_return.controller.dart';

class DetailRefundSection extends StatelessWidget {
  const DetailRefundSection({super.key, required this.controller});

  final DetailReturnController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailReturnController>(builder: (controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Gap(20.h),
        GestureDetector(
          onTap: () => Get.toNamed(Routes.DETAIL_STORE,
              arguments: {'seller_id': controller.detailRefund?.seller?.id}),
          child: Row(
            children: [
              CachedNetworkImage(
                  imageUrl: controller.detailRefund?.seller?.image ?? '',
                  imageBuilder: (context, imageProvider) => CircleAvatar(
                        radius: 22.r,
                        backgroundColor: kPrimaryColor2,
                        backgroundImage: imageProvider,
                      ),
                  placeholder: (context, url) => SizedBox(
                        height: 22.r,
                        width: 22.r,
                        child: const Center(
                          child: CupertinoActivityIndicator(color: kSoftBlack),
                        ),
                      ),
                  errorWidget: (context, url, error) => CircleAvatar(
                        radius: 22.r,
                        backgroundColor: kPrimaryColor2,
                        child: Center(
                          child: Icon(
                            Icons.error,
                            color: kPrimaryColor,
                            size: 18.r,
                          ),
                        ),
                      )),
              Gap(12.w),
              Text(
                controller.detailRefund?.seller?.shopName ?? '-',
                style: text12BlackMedium,
              ),
              const Spacer(),
              Text('Kunjungi toko', style: text12HintRegular),
              Gap(8.w),
              Icon(Icons.chevron_right,
                  color: const Color(0xff808080).withOpacity(0.7), size: 20.r)
            ],
          ),
        ),
        Gap(16.h),
        Divider(
          thickness: 1,
          color: kBorder,
          height: 0,
        ),
        Gap(16.h),
        Column(
          children: List.generate(
            controller.detailRefund?.refundItems?.length ?? 0,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: Uri.tryParse(controller.detailRefund
                                        ?.refundItems?[index].image ??
                                    '')
                                ?.isAbsolute ==
                            true
                        ? controller.detailRefund?.refundItems![index].image ??
                            ''
                        : '',
                    height: 50.r,
                    width: 50.r,
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        height: 120.w,
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
                        height: 50.r,
                        width: 50.r,
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
                  Gap(8.h),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            controller.detailRefund?.refundItems?[index].name ??
                                '',
                            style: text12BlackSemiBold),
                        Gap(6.h),
                        Row(
                          children: [
                            Text(
                                '${controller.detailRefund?.refundItems?[index].quantity ?? 1} x',
                                style: text12HintRegular),
                            Gap(3.w),
                            Text(
                                '${controller.detailRefund?.refundItems?[index].price ?? 10000}'
                                    .toIdrFormat,
                                style: text12HintRegular),
                          ],
                        ),
                      ])
                ],
              ),
            ),
          ),
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Jumlah Pengembalian Dana', style: text12HintRegular),
            Text('${controller.detailRefund?.totalAmount ?? 2000}'.toIdrFormat,
                style: text12BlackRegular)
          ],
        ),
        Gap(8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Disetujui pada', style: text12HintRegular),
            Text(
                controller.detailRefund?.approvedAt
                        ?.split('.')
                        .first
                        .formatDate ??
                    '-',
                style: text12BlackRegular)
          ],
        ),
        Gap(8.h),
        Text('Bukti', style: text12HintRegular),
        Gap(16.h),
        Row(
            children: List.generate(
          controller.detailRefund?.proofs?.length ?? 0,
          (index) => Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CachedNetworkImage(
              imageUrl: controller.detailRefund?.proofs?[index].image ?? '',
              height: 66.r,
              width: 66.r,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return GestureDetector(
                  onTap: () => controller.setSelectedProofsIndex(
                      index,
                      controller.detailRefund?.proofs?[index].description ??
                          ''),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kSofterGrey,
                        borderRadius: AppStyle.borderRadius8All,
                        border: Border.all(
                            color: controller.selectedProofsIndex == index
                                ? kNormalColor
                                : Colors.transparent),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  ),
                );
              },
              placeholder: (context, url) =>
                  const Center(child: CupertinoActivityIndicator()),
              errorWidget: (context, url, error) {
                return Container(
                  height: 66.r,
                  width: 66.r,
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
        )),
        Gap(8.h),
        Visibility(
            visible: controller.selectedProofsIndex != null,
            child: Text(controller.descriptionSelectedProofsIndex ?? '',
                style: text12HintRegular))
      ]);
    });
  }
}
