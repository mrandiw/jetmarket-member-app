import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../components/picker/picker_images.dart';
import '../../../../components/rating/selected_rating.dart';
import '../../../../domain/core/model/model_data/product_review_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/style/app_style.dart';

class ProductReviewItem extends StatelessWidget {
  const ProductReviewItem(
      {super.key,
      this.products,
      required this.textController,
      required this.reviewTextLenght,
      required this.indexProduct,
      required this.imagesReview,
      this.onTapRating,
      this.listenForChange,
      this.changeRating,
      this.onTapCamera,
      this.onTapGallery,
      required this.deleteImage});

  final ProductReviewModel? products;
  final TextEditingController textController;
  final int reviewTextLenght;
  final int indexProduct;
  final List<String> imagesReview;
  final Function()? onTapRating;
  final Function(String value)? listenForChange;
  final Function(int value)? changeRating;
  final Function()? onTapCamera;
  final Function()? onTapGallery;
  final Function(int) deleteImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: Uri.tryParse(products?.image ?? '')?.isAbsolute == true
                  ? products?.image ?? ''
                  : '',
              height: 39.r,
              width: 39.r,
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
                  height: 39.r,
                  width: 39.r,
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
            Gap(12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(products?.name ?? '', style: text12BlackMedium),
                Row(
                  children: [
                    Text("${products?.quantity} x ", style: text12HintRegular),
                    Text("${products?.price}".toIdrFormat,
                        style: text12HintRegular),
                  ],
                )
              ],
            )
          ],
        ),
        Gap(12.h),
        Divider(
          height: 0,
          color: kBorder,
        ),
        Gap(12.h),
        Row(children: [
          Visibility(
            visible: imagesReview.length < 3,
            child: Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                        enterBottomSheetDuration: 200.milliseconds,
                        exitBottomSheetDuration: 200.milliseconds,
                        PickerImages.double(
                          onTapCamera: onTapCamera,
                          onTapGallery: onTapGallery,
                        ));
                  },
                  child: Container(
                    height: 66.r,
                    width: 66.r,
                    decoration: BoxDecoration(
                        color: kPrimaryColor2,
                        borderRadius: AppStyle.borderRadius8All,
                        border:
                            Border.all(color: kPrimaryColor.withOpacity(0.1))),
                    child: const Center(
                      child: Icon(
                        Icons.add_circle_outline_rounded,
                        color: kPrimaryColor,
                      ),
                    ),
                  )),
            ),
          ),
          Visibility(
              visible: imagesReview.isNotEmpty,
              child: Row(
                  children: List.generate(
                imagesReview.length,
                (index) => Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            Uri.tryParse(imagesReview[index])?.isAbsolute ==
                                    true
                                ? imagesReview[index]
                                : '',
                        height: 66.r,
                        width: 66.r,
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
                      Positioned(
                          top: -19,
                          right: -19,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.close_rounded,
                                color: kPrimaryColor,
                                size: 12.r,
                              ))),
                      Positioned(
                          top: -19,
                          right: -19,
                          child: IconButton(
                              onPressed: () {
                                deleteImage(index);
                              },
                              icon: Icon(
                                Icons.circle_outlined,
                                color: kPrimaryColor,
                                size: 18.r,
                              ))),
                    ],
                  ),
                ),
              )))
        ]),
        Gap(12.h),
        SelectedRating(
          onChanged: changeRating,
        ),
        Gap(12.h),
        AppForm(
          textArea: true,
          controller: textController,
          onChanged: listenForChange,
        ),
        Gap(8.h),
        Align(
            alignment: Alignment.centerRight,
            child: Text('$reviewTextLenght/200', style: text11GreyRegular)),
      ],
    );
  }
}
