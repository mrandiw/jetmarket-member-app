import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/components/form/app_form.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/withdraw/controllers/withdraw.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key, required this.controller});
  final WithdrawController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WithdrawController>(builder: (controller) {
      return ListView(
        padding: AppStyle.paddingAll16,
        children: [
          Text('Rekening', style: text12BlackRegular),
          Gap(4.h),
          Container(
            height: 42.h,
            padding: AppStyle.paddingSide8,
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: AppStyle.borderRadius8All,
                border: AppStyle.borderAll),
            child: DropdownButton<String>(
                value: controller.selectedRekening,
                underline: const SizedBox.shrink(),
                isExpanded: true,
                hint: Text('Pilih rekening', style: text12HintForm),
                style: text12BlackRegular,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  size: 18.r,
                ),
                items: controller.rekenings
                    .map((e) => DropdownMenuItem<String>(
                        value: e, child: Text(e, style: text12BlackRegular)))
                    .toList(),
                onChanged: (value) => controller.onChangeRekening(value)),
          ),
          Gap(8.h),
          AppForm(
            type: AppFormType.withLabel,
            label: 'Nomor Rekening',
            controller: controller.rekeningNumberController,
            hintText: 'Masukkan nomor rekening',
            keyboardType: TextInputType.number,
          ),
          Gap(8.h),
          AppForm(
            type: AppFormType.withLabel,
            label: 'Nominal',
            controller: controller.nominalController,
            hintText: 'Masukkan nominal withdraw',
            keyboardType: TextInputType.number,
            onChanged: controller.changeToIdrFormat,
          ),
          Gap(8.h),
          Row(
              children: List.generate(
                  controller.listNominal.length,
                  (index) => Expanded(
                          child: Padding(
                        padding: index == 1
                            ? AppStyle.paddingSide8
                            : EdgeInsets.zero,
                        child: GestureDetector(
                          onTap: () => controller.onChangeNominal(index),
                          child: Container(
                            height: 42.h,
                            decoration: BoxDecoration(
                                border: AppStyle.borderAll,
                                borderRadius: AppStyle.borderRadius8All,
                                color: controller.selectedNominal ==
                                        controller.listNominal[index]
                                    ? kBorder
                                    : kWhite),
                            child: Center(
                                child: Text(
                                    controller.listNominal[index].toIdrFormat,
                                    style: text12BlackRegular)),
                          ),
                        ),
                      )))),
          Gap(12.h),
          AppButton.primary(
            text: 'Withdraw',
            onPressed: controller.selectedRekening != null &&
                    controller.isNominalNotEmpty &&
                    controller.isRekeningNotEmpty
                ? () => controller.withdraw()
                : null,
          )
        ],
      );
    });
  }
}
