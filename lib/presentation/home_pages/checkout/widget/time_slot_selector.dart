import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../domain/core/model/model_data/ongkir_v2_response.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

/// Widget untuk memilih time slot pengiriman dengan quota indicator
class TimeSlotSelector extends StatelessWidget {
  final List<TimeSlot> timeSlots;
  final TimeSlot? selectedSlot;
  final Function(TimeSlot) onSlotSelected;
  final bool enabled;

  const TimeSlotSelector({
    super.key,
    required this.timeSlots,
    this.selectedSlot,
    required this.onSlotSelected,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (timeSlots.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time, size: 16.sp, color: kPrimaryColor),
            Gap(4.w),
            Text('Pilih Waktu Pengiriman:', style: text12BlackMedium),
            Gap(4.w),
            Text('(Wajib)',
                style: text10BlackRegular.copyWith(color: kErrorColor)),
          ],
        ),
        Gap(8.h),
        ...timeSlots.map((slot) => _buildTimeSlotItem(slot)),
      ],
    );
  }

  Widget _buildTimeSlotItem(TimeSlot slot) {
    final isSelected = selectedSlot?.id == slot.id;
    final isFull = slot.isFull;
    final canSelect = enabled && !isFull;

    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected
              ? kPrimaryColor
              : isFull
                  ? kBorder.withOpacity(0.5)
                  : kBorder,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: AppStyle.borderRadius8All,
        color: isFull
            ? kGrey.withOpacity(0.1)
            : isSelected
                ? kPrimaryColor.withOpacity(0.05)
                : kWhite,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: canSelect ? () => onSlotSelected(slot) : null,
          borderRadius: AppStyle.borderRadius8All,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                // Radio button
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? kPrimaryColor
                          : isFull
                              ? kGrey
                              : kBorder,
                      width: 2,
                    ),
                    color: isSelected ? kPrimaryColor : Colors.transparent,
                  ),
                  child: isSelected
                      ? Icon(Icons.check, size: 12.sp, color: kWhite)
                      : null,
                ),
                Gap(12.w),

                // Slot info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        slot.name ?? 'Time Slot',
                        style: text14BlackMedium.copyWith(
                          color: isFull ? kGrey : kBlack,
                        ),
                      ),
                      Gap(4.h),
                      _buildQuotaInfo(slot),
                    ],
                  ),
                ),

                // Status badge
                _buildStatusBadge(slot),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuotaInfo(TimeSlot slot) {
    final quotaPercent = slot.quotaPercentage;
    final remainingQuota = slot.remainingQuota ?? 0;
    final maxOrders = slot.maxOrders ?? 0;

    Color quotaColor;
    if (slot.isFull) {
      quotaColor = kErrorColor;
    } else if (slot.isAlmostFull) {
      quotaColor = Colors.orange;
    } else {
      quotaColor = kSuccessColor;
    }

    return Row(
      children: [
        // Quota bar
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: kGrey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (quotaPercent / 100).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: quotaColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ),
              Gap(4.h),
              Text(
                'Sisa quota: $remainingQuota/$maxOrders slot',
                style: text10BlackRegular.copyWith(
                  color: quotaColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(TimeSlot slot) {
    if (slot.isFull) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: kErrorColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.block, size: 12.sp, color: kErrorColor),
            Gap(4.w),
            Text(
              'PENUH',
              style: text10BlackRegular.copyWith(
                color: kErrorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else if (slot.isAlmostFull) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber_rounded,
                size: 12.sp, color: Colors.orange),
            Gap(4.w),
            Text(
              'Hampir Penuh',
              style: text10BlackRegular.copyWith(
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: kSuccessColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 12.sp, color: kSuccessColor),
            Gap(4.w),
            Text(
              'Tersedia',
              style: text10BlackRegular.copyWith(
                color: kSuccessColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: AppStyle.borderRadius8All,
        border: Border.all(color: Colors.orange.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.orange, size: 20.sp),
          Gap(12.w),
          Expanded(
            child: Text(
              'Tidak ada waktu pengiriman tersedia untuk tanggal ini',
              style: text12BlackRegular.copyWith(color: Colors.orange.shade700),
            ),
          ),
        ],
      ),
    );
  }
}
