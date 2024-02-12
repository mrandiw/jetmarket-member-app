import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/time_ago.dart';
import '../../../../components/button/app_button.dart';
import '../../../../components/rating/rating_star.dart';
import '../../../../domain/core/model/model_data/order_product_model.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key, required this.data, required this.status, this.actionOrder});

  final OrderProductModel data;
  final String status;
  final Function()? actionOrder;

  @override
  Widget build(BuildContext context) {
    return status == 'finished' ? finishedCard() : reviewedCard();
  }

  Widget finishedCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_ORDER,
          arguments: [data.id, null, null, null]),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
        shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: AppStyle.paddingAll12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Selesai', style: text12SucessRegular),
                  ],
                )),
            Divider(height: 0, thickness: 1, color: kBorder),
            Padding(
              padding: AppStyle.paddingAll12,
              child: Row(
                children: [
                  CachedNetworkImage(
                    imageUrl: Uri.tryParse(data.image ?? '')?.isAbsolute == true
                        ? data.image ?? ''
                        : '',
                    height: 70.r,
                    width: 70.r,
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
                        height: 70.r,
                        width: 70.r,
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
                        Text(data.name ?? '', style: text12BlackSemiBold),
                        Gap(6.h),
                        Row(
                          children: [
                            Text('${data.price}'.toIdrFormat,
                                style: text12BlackRegular),
                          ],
                        ),
                      ])
                ],
              ),
            ),
            Center(
                child: Text(
              'Lihat ${data.totalProduct} produk lainnya',
              style: text12HintRegular,
            )),
            Gap(12.h),
            Divider(height: 0, thickness: 1, color: kBorder),
            Padding(
              padding: AppStyle.paddingAll12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total bayar', style: text12BlackRegular),
                      Text('${data.totalPrice}'.toIdrFormat,
                          style: text12PrimaryMedium)
                    ],
                  ),
                  AppButton.primarySmall(
                    text: 'Review',
                    onPressed: actionOrder,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewedCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
      shape: RoundedRectangleBorder(
          borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
      child: Padding(
        padding: AppStyle.paddingAll12,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: Uri.tryParse(data.image ?? '')?.isAbsolute == true
                  ? data.image ?? ''
                  : '',
              height: 70.r,
              width: 70.r,
              fit: BoxFit.cover,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: 70.w,
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
                  height: 70.r,
                  width: 70.r,
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
            RatingStars(
              rating: data.review?.rating?.toDouble() ?? 0,
            ),
            Gap(8.h),
            Row(
              children: [
                Text('Oleh', style: text11GreyRegular),
                Gap(8.w),
                Text(data.review?.customer?.name ?? '',
                    style: text12BlackRegular),
              ],
            ),
            Gap(8.h),
            Text(
              "${data.review?.text}",
              style: text12HintForm,
            ),
            Gap(12.h),
            Text(
              '${data.review?.createdAt}'.timeAgo(),
              style: text12HintForm,
            ),
          ],
        ),
      ),
    );
  }
}
