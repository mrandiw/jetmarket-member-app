import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/controllers/edit_address.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAddressController>(builder: (controller) {
      return Container(
        height: 80.h,
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
        child: AppButton.primary(
          text: 'Pilih Alamat',
          onPressed: controller.selectedAddress != 99
              ? () => controller.choiceAddress()
              : null,
        ),
      );
    });
  }
}
