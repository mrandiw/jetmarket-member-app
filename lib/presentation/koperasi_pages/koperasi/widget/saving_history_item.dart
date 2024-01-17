import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../domain/core/model/model_data/saving_history_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class SavingHistoryItem extends StatelessWidget {
  const SavingHistoryItem({super.key, required this.index, required this.data});

  final int index;
  final SavingHistoryModel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DETAIL_MENABUNG, arguments: data.id),
      child: Container(
          padding: AppStyle.paddingAll12,
          decoration: BoxDecoration(
              color: kWhite,
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(data.title ?? '', style: text12BlackMedium),
                  Text(
                    data.createdAt?.formatDate ?? '',
                    style: text10HintRegular,
                  ),
                ],
              ),
              Gap(4.hr),
              Text(
                data.body ?? '',
                style: text11GreyRegular,
              ),
            ],
          )),
    );
  }
}
