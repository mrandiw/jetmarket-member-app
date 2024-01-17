import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/controllers/payment_topup_saldo.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class TutorialPayment extends StatelessWidget {
  const TutorialPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentTopupSaldoController>(builder: (controller) {
      return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Visibility(
            visible: controller.tutorialPayment?.tab1 != null,
            child: _tabWidget(controller.tutorialPayment?.toJson()['tab1'],
                controller.tutorialPayment?.tabs, context, 0)),
        Visibility(
            visible: controller.tutorialPayment?.tab2 != null,
            child: _tabWidget(controller.tutorialPayment?.toJson()['tab2'],
                controller.tutorialPayment?.tabs, context, 1)),
        Visibility(
            visible: controller.tutorialPayment?.tab3 != null,
            child: _tabWidget(controller.tutorialPayment?.toJson()['tab3'],
                controller.tutorialPayment?.tabs, context, 2)),
        Visibility(
            visible: controller.tutorialPayment?.tab4 != null,
            child: _tabWidget(controller.tutorialPayment?.toJson()['tab4'],
                controller.tutorialPayment?.tabs, context, 3)),
      ]);
    });
  }

  Widget _tabWidget(List<dynamic>? tabData, List<String>? tab,
      BuildContext context, int index) {
    if (tabData != null) {
      return SizedBox(
        width: Get.width,
        child: Theme(
          data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              highlightColor: kWhite,
              hoverColor: kWhite,
              focusColor: kWhite,
              splashColor: kWhite),
          child: ExpansionTile(
            initiallyExpanded: index == 0 ? true : false,
            childrenPadding: AppStyle.paddingSide8,
            title: Text(
              tab?[index] ?? '',
              style: text12BlackSemiBold,
            ),
            iconColor: kBlack,
            tilePadding: EdgeInsets.zero,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                  tabData.length,
                  (index) => processStep(
                    stepTitle: tabData[index]['title'] ?? '',
                    stepDetails: tabData[index]['content'] ?? [],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget processStep(
      {required String stepTitle, required List<String> stepDetails}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stepTitle,
          style: text12BlackSemiBold,
        ),
        Gap(6.h),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stepDetails
              .map((detail) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Text(
                      detail,
                      style: text12BlackRegular,
                    ),
                  ))
              .toList(),
        ),
        Gap(20.h),
      ],
    );
  }
}
