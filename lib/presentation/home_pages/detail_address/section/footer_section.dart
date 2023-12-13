import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_address/controllers/detail_address.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});
  final DetailAddressController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110.h,
      padding: AppStyle.paddingAll16,
      decoration: BoxDecoration(
          color: kWhite,
          borderRadius: AppStyle.borderRadius20Top,
          boxShadow: [
            BoxShadow(
                color: const Color(0xffE3BEBD).withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -6))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                height: 22.r,
                width: 22.r,
                child: Transform.scale(
                    scale: 0.8,
                    child: Obx(() {
                      return Checkbox(
                          activeColor: kPrimaryColor,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius6All,
                          ),
                          value: controller.mainAddress.value,
                          onChanged: (value) =>
                              controller.onChangeMainAddress(value!));
                    })),
              ),
              Gap(8.h),
              Text("Jadikan Alamat Utama", style: text12HintRegular),
            ],
          ),
          Gap(8.h),
          AppButton.primary(
            text: 'Simpan',
            onPressed: () => controller.saveAddress(),
          ),
        ],
      ),
    );
  }
}
