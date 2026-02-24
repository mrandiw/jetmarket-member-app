import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

/// Widget untuk memilih tanggal pengiriman
/// Min: Tomorrow (H+1), Max: +7 days from now
class DeliveryDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;
  final bool enabled;

  const DeliveryDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: AppStyle.borderRadius8All,
        border: Border.all(color: kBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: kPrimaryColor),
              Gap(8.w),
              Text('Tanggal Pengiriman:', style: text12BlackMedium),
            ],
          ),
          Gap(8.h),
          InkWell(
            onTap: enabled ? () => _showDatePicker(context) : null,
            borderRadius: AppStyle.borderRadius8All,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: enabled
                    ? kPrimaryColor.withValues(alpha: 0.05)
                    : kGrey.withValues(alpha: 0.05),
                borderRadius: AppStyle.borderRadius8All,
                border: Border.all(
                  color: enabled ? kPrimaryColor.withValues(alpha: 0.3) : kBorder,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _formatDateLong(selectedDate),
                          style: text14BlackMedium,
                        ),
                        Gap(2.h),
                        Text(
                          _getRelativeDate(selectedDate),
                          style:
                              text12BlackRegular.copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: enabled ? kPrimaryColor : kGrey,
                    size: 24.sp,
                  ),
                ],
              ),
            ),
          ),
          Gap(6.h),
          Text(
            'Pengiriman minimal H+1 (besok)',
            style: text10BlackRegular.copyWith(color: kGrey),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    final maxDate = DateTime.now().add(const Duration(days: 7));

    final results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: kPrimaryColor,
        weekdayLabels: ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'],
        weekdayLabelTextStyle: text12BlackMedium,
        controlsTextStyle: text14BlackMedium,
        firstDate: tomorrow,
        lastDate: maxDate,
        currentDate: selectedDate,
        selectableDayPredicate: (day) {
          // Only allow dates from tomorrow to +7 days
          return day.isAfter(DateTime.now()) &&
              day.isBefore(maxDate.add(const Duration(days: 1)));
        },
        dayTextStyle: text12BlackRegular,
        selectedDayTextStyle: text12BlackRegular.copyWith(
          color: kWhite,
          fontWeight: FontWeight.w600,
        ),
        disabledDayTextStyle: text12BlackRegular.copyWith(color: kGrey),
        todayTextStyle: text12BlackRegular.copyWith(
          color: kPrimaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      dialogSize: Size(320.w, 400.h),
      borderRadius: BorderRadius.circular(12.r),
      dialogBackgroundColor: kWhite,
    );

    if (results != null && results.isNotEmpty && results[0] != null) {
      onDateSelected(results[0]!);
    }
  }

  String _formatDateLong(DateTime date) {
    // Format: "Wednesday, 15 December 2025" (fallback to English if locale not initialized)
    // To use Indonesian: add intl package initialization in main.dart
    try {
      return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
    } catch (e) {
      // Fallback jika locale belum di-initialize
      return DateFormat('EEEE, d MMMM yyyy').format(date);
    }
  }

  String _getRelativeDate(DateTime date) {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == tomorrow) {
      return 'Besok';
    } else if (dateOnly == DateTime(now.year, now.month, now.day + 2)) {
      return 'Lusa';
    } else {
      final diff =
          dateOnly.difference(DateTime(now.year, now.month, now.day)).inDays;
      return 'H+$diff';
    }
  }
}

/// Helper function untuk format date ke API format
String formatDateForApi(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}
