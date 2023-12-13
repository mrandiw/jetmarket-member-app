import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/parent_scaffold.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../components/button/back_button.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/assets/assets_svg.dart';
import 'controllers/detail_payment_register.controller.dart';
import 'section/button_section.dart';
import 'section/detail_section.dart';
import 'section/header_section.dart';

class DetailPaymentRegisterScreen
    extends GetView<DetailPaymentRegisterController> {
  const DetailPaymentRegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Scaffold successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      body: SafeArea(
        child: SizedBox(
          height: Get.height.hr,
          width: Get.width.wr,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const HeaderSection(),
              const DetailSection(),
              Positioned(
                  top: 16.h,
                  left: 16.w,
                  child: GestureDetector(
                    onTap: () => SystemNavigator.pop(),
                    child: Container(
                      width: 24.r,
                      height: 24.r,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xff2D2D2D).withOpacity(0.2)),
                      child: Center(
                          child: SvgPicture.asset(
                        arrowForward,
                        height: 12.r,
                        width: 12.r,
                        colorFilter:
                            const ColorFilter.mode(kWhite, BlendMode.srcIn),
                      )),
                    ),
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonSection(controller: controller),
    );
  }
}
