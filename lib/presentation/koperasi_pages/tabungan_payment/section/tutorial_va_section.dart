import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../domain/core/model/model_data/tutorial_payment_va_model.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class TutorialVaSection extends StatelessWidget {
  const TutorialVaSection({
    super.key,
    required this.data,
    required this.index,
  });

  final TutorialPaymentVaModel data;
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return _tabWidget(data.toJson()['tab1']);
      case 1:
        return _tabWidget(data.toJson()['tab2']);
      case 2:
        return _tabWidget(data.toJson()['tab3']);
      case 3:
        return _tabWidget(data.toJson()['tab4']);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _tabWidget(List<dynamic>? tabData) {
    if (tabData != null) {
      return Padding(
        padding: AppStyle.paddingVert16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(
            tabData.length,
            (index) => processStep(
              stepTitle: tabData[index]['title'] ?? '',
              stepDetails: tabData[index]['content'] ?? [],
            ),
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
