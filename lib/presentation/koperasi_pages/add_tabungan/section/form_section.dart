import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan/controllers/add_tabungan.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_nominal.dart';
import '../../../../components/formatter/nominal_formatter.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';

class FormSection extends StatelessWidget {
  const FormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: GetBuilder<AddTabunganController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Jadwal Menabung', style: text12BlackRegular),
            Gap(8.hr),
            GestureDetector(
              onTap: () => controller.openCalendarView(),
              child: Container(
                height: 42.h,
                padding: AppStyle.paddingAll12,
                decoration: BoxDecoration(
                    borderRadius: AppStyle.borderRadius8All,
                    color: kWhite,
                    border: AppStyle.borderAll),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        controller.selectedDateOnlyPicker != ""
                            ? controller.selectedDateOnlyPicker
                            : 'Pilih Tanggal Tagihan',
                        style: controller.selectedDateOnlyPicker != ""
                            ? text12BlackRegular
                            : text12HintRegular),
                    SvgPicture.asset(calendar)
                  ],
                ),
              ),
            ),
            // Visibility(
            //     visible: controller.selectedDateOnlyPicker != "",
            //     child: Padding(
            //       padding: EdgeInsets.only(top: 4.hr),
            //       child: Text(
            //           '*Tagihan akan otomatis dipotong setiap tanggal ${controller.selectedDateOnlyPicker}',
            //           style: text12HintRegular),
            //     )),
            Gap(16.hr),
            Text('Nominal', style: text12BlackRegular),
            Gap(8.hr),
            AppFormNominal(
              controller: controller.nominalController,
              onChanged: controller.listenNominalForm,
              inputFormatters: [NominalFormatter()],
            ),
          ],
        );
      }),
    );
  }
}
