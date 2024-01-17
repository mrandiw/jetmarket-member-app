import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/bottom_sheet/app_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/add_tabungan/controllers/add_tabungan.controller.dart';

import '../../../../infrastructure/theme/app_colors.dart';

class PickerDate extends StatelessWidget {
  const PickerDate({super.key, required this.controller});
  final AddTabunganController controller;

  @override
  Widget build(BuildContext context) {
    final config = CalendarDatePicker2Config(
        selectedDayHighlightColor: kSecondaryColor,
        weekdayLabels: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'],
        weekdayLabelTextStyle: text14HintRegular,
        centerAlignModePicker: true,
        firstDayOfWeek: 1,
        controlsHeight: 50,
        controlsTextStyle: text14BlackMedium,
        dayTextStyle: text14BlackMedium,
        calendarType: CalendarDatePicker2Type.single,
        dayBorderRadius: BorderRadius.circular(24.r),
        customModePickerIcon: const SizedBox());

    return AppBottomSheet.witoutFooter(
        title: '',
        child: GetBuilder<AddTabunganController>(builder: (controller) {
          return CalendarDatePicker2(
            config: config,
            value: controller.datePicker,
            onValueChanged: (values) => controller.pickDate(values),
          );
        }));
  }
}
