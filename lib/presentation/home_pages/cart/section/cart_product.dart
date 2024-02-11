import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/cart/controllers/cart.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../domain/core/model/model_data/cart_product.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({super.key, required this.data, required this.index});
  final CartProduct data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 22.r,
            width: 22.r,
            child: Transform.scale(
              scale: 1,
              child: Checkbox(
                  value: controller.isSelectedAllCartIdBySeller(data),
                  activeColor: kPrimaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppStyle.borderRadius6All,
                  ),
                  side: const BorderSide(color: kSoftGrey, width: 1.2),
                  onChanged: (value) =>
                      controller.selectProductBySeller(value!, data)),
            ),
          ),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(3.h),
                Row(
                  children: [
                    Text(data.seller?.name ?? '-', style: text12BlackMedium)
                  ],
                ),
                Gap(8.h),
                Column(
                    children: List.generate(data.products?.length ?? 0,
                        (indexProduct) {
                  return _cartProduct(data.products?[indexProduct], data.seller,
                      index, indexProduct, controller);
                }))
              ],
            ),
          ),
        ],
      );
    });
  }
}

Widget _cartProduct(Products? data, Seller? seller, int indexSeller, int index,
    CartController controller) {
  return Padding(
    padding: AppStyle.paddingBottom8,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Container(
          padding: AppStyle.paddingAll12,
          decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll,
              color: kWhite),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22.r,
                    width: 22.r,
                    child: Transform.scale(
                      scale: 1,
                      child: Checkbox(
                          value: controller.isSelectedCartId(data?.cartId ?? 0),
                          activeColor: kPrimaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius6All,
                          ),
                          side: const BorderSide(color: kSoftGrey, width: 1.2),
                          onChanged: (value) {
                            CartProduct cartProduct =
                                CartProduct(seller: seller, products: [data!]);
                            controller.selectProduct(
                                value!, cartProduct, data.cartId ?? 0);
                          }),
                    ),
                  ),
                  Gap(8.w),
                  CachedNetworkImage(
                    imageUrl: data?.thumbnail ?? '',
                    imageBuilder: (context, imageProvider) => Container(
                      height: 57.h,
                      width: 57.h,
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
                      height: 57.h,
                      width: 57.h,
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
                  Gap(12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data?.name ?? '',
                          style: text12BlackRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(4.h),
                        Row(
                          children: [
                            Text(
                              "${data?.promo}".toIdrFormat,
                              style: text12BlackRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(12.w),
                            Text(
                              "${data?.price}".toIdrFormat,
                              style: text10lineThroughRegular,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Gap(6.h),
                        Text(
                          "${data?.weight ?? 0} gram",
                          style: text10HintRegular,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(6.h),
                        Text(
                          "Variasi: ${data?.variantName ?? '-'}",
                          style: text10BlackRegular,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Gap(12.h),
              Row(
                children: [
                  Visibility(
                    visible:
                        controller.isWriteNote[indexSeller][index] == false,
                    child: data?.note == ""
                        ? GestureDetector(
                            onTap: () =>
                                controller.openWriteNote(indexSeller, index),
                            child: Text(
                                data?.note == ""
                                    ? 'Tulis Catatan'
                                    : data?.note ?? '',
                                style: data?.note == ""
                                    ? text10SuccessMedium
                                    : text10HintRegular))
                        : Row(
                            children: [
                              Text(data?.note ?? '', style: text10HintRegular),
                              Gap(4.w),
                              GestureDetector(
                                  onTap: () => controller.openWriteNote(
                                      indexSeller, index),
                                  child: Icon(
                                    Icons.edit,
                                    color: kSoftBlack,
                                    size: 12.r,
                                  ))
                            ],
                          ),
                  ),
                  Visibility(
                      visible:
                          controller.isWriteNote[indexSeller][index] == true,
                      child: SizedBox(
                        height: 36.h,
                        width: 130,
                        child: TextFormField(
                          cursorColor: kSuccessColor,
                          style: text10HintRegular,
                          onEditingComplete: () => controller.closeWriteNote(
                              indexSeller, index, data?.cartId ?? 0),
                          controller: controller.notesController[indexSeller]
                              [index],
                          decoration: InputDecoration(
                              label: Text('Catatan Barang ini',
                                  style: text10HintRegular),
                              hintText: '',
                              border: _border,
                              enabledBorder: _border,
                              focusedBorder: _border,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 2.h)),
                        ),
                      )),
                  const Spacer(),
                  GestureDetector(
                      onTap: () => controller.deleteProduct(
                          indexSeller, data?.cartId ?? 0),
                      child: SvgPicture.asset(delete)),
                  Gap(16.w),
                  GestureDetector(
                    onTap: () => controller.decrementProduct(
                        data?.cartId ?? 0, data?.qty ?? 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius6All,
                          color: kWhite,
                          border: AppStyle.borderAll),
                      child: const Center(
                          child: Icon(
                        Icons.remove,
                        color: kSofterGrey,
                      )),
                    ),
                  ),
                  Gap(12.w),
                  Text(data?.qty.toString() ?? '', style: text12BlackRegular),
                  Gap(12.w),
                  GestureDetector(
                    onTap: () => controller.incrementProduct(
                        data?.cartId ?? 0, data?.qty ?? 0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: AppStyle.borderRadius6All,
                          color: kWhite,
                          border: AppStyle.borderAll),
                      child: const Center(
                          child: Icon(
                        Icons.add,
                        color: kSofterGrey,
                      )),
                    ),
                  )
                ],
              )
            ],
          ),
        ))
      ],
    ),
  );
}

OutlineInputBorder get _border {
  return OutlineInputBorder(
      borderRadius: AppStyle.borderRadius8All,
      borderSide: const BorderSide(color: kSuccessColor));
}
