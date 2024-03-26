import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../domain/core/model/model_data/cart_product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.data,
    required this.isWriteNote,
    this.increment,
    this.decrement,
    this.openWriteNote,
    this.closeWriteNote,
    this.controller,
  });

  final Products? data;
  final bool isWriteNote;
  final Function()? increment;
  final Function()? decrement;
  final Function()? openWriteNote;
  final Function()? closeWriteNote;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: data?.thumbnail ?? '',
              imageBuilder: (context, imageProvider) => Container(
                height: 64.h,
                width: 77.w,
                decoration: BoxDecoration(
                  color: kSofterGrey,
                  borderRadius: AppStyle.borderRadius8All,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) =>
                  const CupertinoActivityIndicator(color: kSoftBlack),
              errorWidget: (context, url, error) => Container(
                height: 64.h,
                width: 77.w,
                decoration: BoxDecoration(
                    color: kSofterGrey,
                    borderRadius: AppStyle.borderRadius6All),
                child: Center(
                  child: Icon(
                    Icons.error,
                    color: kPrimaryColor,
                    size: 18.r,
                  ),
                ),
              ),
            ),
            Gap(8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data?.name ?? '', style: text12BlackRegular),
                  Visibility(
                    visible: (data?.promo ?? 0) > 0,
                    child: Text('${data?.price}'.toIdrFormat,
                        style: text10lineThroughRegular),
                  ),
                  Gap(6.h),
                  Row(
                    children: [
                      Text(
                          '${(data?.promo ?? 0) <= 0 ? data?.price : data?.promo}'
                              .toIdrFormat,
                          style: text12PrimaryMedium),
                      const Spacer(),
                      Text("${data?.qty}x", style: text12BlackRegular),
                      Gap(16.wr)
                    ],
                  ),
                ],
              ),
            ),

            // GestureDetector(
            //   onTap: decrement,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: AppStyle.borderRadius6All,
            //         color: kWhite,
            //         border: AppStyle.borderAll),
            //     child: const Center(
            //         child: Icon(
            //       Icons.remove,
            //       color: kSofterGrey,
            //     )),
            //   ),
            // ),
            // Gap(12.w),
            // Expanded(
            //   flex: 1,
            //   child: Center(
            //     child: Text("${data?.qty}", style: text12BlackRegular),
            //   ),
            // ),
            // Gap(12.w),
            // GestureDetector(
            //   onTap: increment,
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: AppStyle.borderRadius6All,
            //         color: kWhite,
            //         border: AppStyle.borderAll),
            //     child: const Center(
            //         child: Icon(
            //       Icons.add,
            //       color: kSofterGrey,
            //     )),
            //   ),
            // )
          ],
        ),
        Gap(12.h),
        Visibility(
          visible: isWriteNote,
          child: data?.note == ""
              ? GestureDetector(
                  onTap: openWriteNote,
                  child: Text(
                      data?.note == "" ? 'Tulis Catatan' : data?.note ?? '',
                      style: data?.note == ""
                          ? text10SuccessMedium
                          : text10HintRegular))
              : Row(
                  children: [
                    Text(data?.note ?? '', style: text10HintRegular),
                    Gap(4.w),
                    GestureDetector(
                        onTap: openWriteNote,
                        child: Icon(
                          Icons.edit,
                          color: kSoftBlack,
                          size: 12.r,
                        ))
                  ],
                ),
        ),
        Visibility(
            visible: !isWriteNote,
            child: SizedBox(
              height: 36.h,
              width: 130,
              child: TextFormField(
                cursorColor: kSuccessColor,
                style: text10HintRegular,
                onEditingComplete: closeWriteNote,
                controller: controller,
                decoration: InputDecoration(
                    label: Text('Catatan Barang ini', style: text10HintRegular),
                    hintText: '',
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h)),
              ),
            )),
        Gap(8.h)
      ],
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: AppStyle.borderRadius8All,
        borderSide: const BorderSide(color: kSuccessColor));
  }
}
