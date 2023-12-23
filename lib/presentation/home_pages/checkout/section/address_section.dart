import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class AddressSection extends StatelessWidget {
  const AddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: GetBuilder<CheckoutController>(builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alamat Pengiriman', style: text14BlackMedium),
                  TextButton(
                      onPressed: () => Get.toNamed(Routes.EDIT_ADDRESS),
                      child: Text(
                          controller.address != null ? 'Ubah' : 'Tambah Alamat',
                          style: text12NormalRegular))
                ],
              ),
              Visibility(
                visible: controller.address != null,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(controller.address?.label ?? '',
                            style: text12HintRegular),
                        Gap(8.w),
                        Visibility(
                          visible: controller.address?.isMain ?? false,
                          child: Container(
                            padding: AppStyle.paddingAll8,
                            decoration: BoxDecoration(
                                borderRadius: AppStyle.borderRadius6All,
                                color: kPrimaryColor2),
                            child: Center(
                                child:
                                    Text('Utama', style: text11PrimaryRegular)),
                          ),
                        )
                      ],
                    ),
                    Gap(6.h),
                    Row(
                      children: [
                        Text(controller.address?.personName ?? '',
                            style: text12HintRegular),
                        Gap(8.w),
                        Text(controller.address?.personPhone ?? '',
                            style: text12HintRegular),
                      ],
                    ),
                    Gap(6.h),
                    Text(controller.address?.address ?? '',
                        style: text12HintRegular),
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
