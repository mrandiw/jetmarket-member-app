import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import 'package:jetmarket/components/parent/error_page.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../components/button/back_button.dart';
import '../../../../components/parent/parent_scaffold.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import 'controllers/payment_register.controller.dart';
import 'section/button_section.dart';
import 'section/payment_section.dart';
import 'section/header_section.dart';
import 'section/total_section.dart';

class PaymentRegisterScreen extends GetView<PaymentRegisterController> {
  const PaymentRegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getRegistrasiAmount();
    return Obx(
      () => controller.totalAmount.value == "0"
          ? Scaffold(
              body: Container(
                height: Get.height,
                width: Get.width,
                color: Colors.white,
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 9,
                          child: AppForm(
                            type: AppFormType.withLabel,
                            controller: controller.referralController,
                            label: 'Masukan Ulang Kode Referal',
                            hintText: 'Isi kode referal disini',
                          ),
                        ),
                        Gap(8.wr),
                        Expanded(
                          flex: 4,
                          child: Container(
                            margin: const EdgeInsets.only(top: 24),
                            child: AppButton.primary(
                              actionStatus: controller.actionClaimStatus,
                              text: 'Claim',
                              onPressed: () => controller.checkReferralCode(),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      controller.referralMessage.value,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    AppButton.primary(
                      actionStatus: controller.actionClaimStatus,
                      text: 'Tidak Punya Kode Referal',
                      onPressed: () => controller.fetchCost(
                          'MEMBER_BIAYA_REGISTRASI', false),
                    ),
                  ],
                ),
              ),
            )
          : ParentScaffold(
              onLoading: const LoadingPages(),
              onError: const ErrorPage(),
              onSuccess: successWidget(),
              status: controller.screenStatus.value,
            ),
    );
  }

  Widget successWidget() {
    return Scaffold(
      backgroundColor: kWhite,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const HeaderSection(),
            const PaymentSection(),
            Positioned(top: 46.r, left: 16.r, child: AppBackButton.circle())
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TotalSection(),
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: ButtonSection(controller: controller),
          ),
        ],
      ),
    );
  }
}
