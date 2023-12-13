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

class ListProduct extends StatelessWidget {
  const ListProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 22.r,
                  width: 22.r,
                  child: Transform.scale(
                    scale: 1,
                    child: Checkbox(
                        value: controller.selectAll,
                        activeColor: kPrimaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppStyle.borderRadius6All,
                        ),
                        onChanged: (value) =>
                            controller.selectAllProduct(value!)),
                  ),
                ),
                Gap(8.w),
                Text('Pilih Semua Produk', style: text12BlackRegular),
                const Spacer(),
                TextButton(
                    style: TextButton.styleFrom(foregroundColor: kPrimaryColor),
                    onPressed: () => controller.deleteAllProduct(),
                    child: Text(
                      'Hapus',
                      style: text12PrimaryRegular,
                    ))
              ],
            ),
            Gap(8.h),
            Column(
                children: List.generate(
                    controller.dataCarts.length,
                    (index) => Padding(
                          padding: AppStyle.paddingBottom12,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 22.r,
                                width: 22.r,
                                child: Transform.scale(
                                  scale: 1,
                                  child: Checkbox(
                                      value: controller.addForBuy.contains(
                                          controller.dataCarts[index]),
                                      activeColor: kPrimaryColor,
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      visualDensity: VisualDensity.compact,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: AppStyle.borderRadius6All,
                                      ),
                                      onChanged: (value) =>
                                          controller.selectProduct(value!,
                                              controller.dataCarts[index])),
                                ),
                              ),
                              Gap(12.w),
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
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              AppStyle.borderRadius8All,
                                          child: Image.network(
                                            'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                            height: 57.r,
                                            width: 57.r,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Gap(12.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.dataCarts[index]
                                                  ['produc_name'],
                                              style: text12BlackRegular,
                                            ),
                                            Gap(4.h),
                                            Row(
                                              children: [
                                                Text(
                                                  "${controller.dataCarts[index]['promo_price']}"
                                                      .toIdrFormat,
                                                  style: text12BlackRegular,
                                                ),
                                                Gap(12.w),
                                                Text(
                                                  "${controller.dataCarts[index]['price']}"
                                                      .toIdrFormat,
                                                  style:
                                                      text10lineThroughRegular,
                                                ),
                                              ],
                                            ),
                                            Gap(12.w),
                                            Text(
                                              "${controller.dataCarts[index]['berat']} gram",
                                              style: text10HintRegular,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Gap(12.h),
                                    Row(
                                      children: [
                                        Visibility(
                                          visible:
                                              controller.isWriteNote[index] ==
                                                  false,
                                          child: GestureDetector(
                                              onTap: controller.dataCarts[index]
                                                          ['note'] ==
                                                      ""
                                                  ? () => controller
                                                      .openWriteNote(index)
                                                  : null,
                                              child: Text(
                                                  controller.dataCarts[index]
                                                              ['note'] ==
                                                          ""
                                                      ? 'Tulis Catatan'
                                                      : controller.dataCarts[index]
                                                          ['note'],
                                                  style:
                                                      controller.dataCarts[index]
                                                                  ['note'] ==
                                                              ""
                                                          ? text10SuccessMedium
                                                          : text10HintRegular)),
                                        ),
                                        Visibility(
                                            visible:
                                                controller.isWriteNote[index] ==
                                                    true,
                                            child: SizedBox(
                                              height: 36.h,
                                              width: 130,
                                              child: TextFormField(
                                                cursorColor: kSuccessColor,
                                                style: text10HintRegular,
                                                onEditingComplete: () =>
                                                    controller
                                                        .closeWriteNote(index),
                                                controller: controller
                                                    .notesController[index],
                                                decoration: InputDecoration(
                                                    label: Text(
                                                        'Catatan Barang ini',
                                                        style:
                                                            text10HintRegular),
                                                    hintText: '',
                                                    border: _border,
                                                    enabledBorder: _border,
                                                    focusedBorder: _border,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8.w,
                                                            vertical: 2.h)),
                                              ),
                                            )),
                                        const Spacer(),
                                        GestureDetector(
                                            onTap: () =>
                                                controller.deleteProduct(
                                                    controller.dataCarts[index],
                                                    index),
                                            child: SvgPicture.asset(delete)),
                                        Gap(16.w),
                                        GestureDetector(
                                          onTap: () => controller
                                              .decrementProduct(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    AppStyle.borderRadius6All,
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
                                        Text(
                                            controller.dataCarts[index]['total']
                                                .toString(),
                                            style: text12BlackRegular),
                                        Gap(12.w),
                                        GestureDetector(
                                          onTap: () => controller
                                              .incrementProduct(index),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    AppStyle.borderRadius6All,
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
                        )))
          ],
        ),
      );
    });
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
        borderRadius: AppStyle.borderRadius8All,
        borderSide: const BorderSide(color: kSuccessColor));
  }
}
