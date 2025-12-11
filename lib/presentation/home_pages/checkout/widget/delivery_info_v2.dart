import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../../domain/core/model/model_data/ongkir_v2_response.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';
import 'time_slot_selector.dart';

/// Widget untuk menampilkan detail delivery info dengan tiered pricing
class DeliveryInfoV2 extends StatelessWidget {
  final OngkirV2Response ongkirInfo;
  final TimeSlot? selectedTimeSlot;
  final Function(TimeSlot)? onTimeSlotSelected;
  final bool isLoading;

  const DeliveryInfoV2({
    super.key,
    required this.ongkirInfo,
    this.selectedTimeSlot,
    this.onTimeSlotSelected,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: AppStyle.borderRadius8All,
        border: Border.all(
          color: _getBorderColor(),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Gap(12.h),
          _buildDistanceInfo(),
          Gap(8.h),
          _buildPricingInfo(),

          // Show time slot selector jika free ongkir
          if (_isFreeOngkir && _hasTimeSlots) ...[
            Gap(12.h),
            Divider(color: kBorder, height: 1),
            Gap(12.h),
            TimeSlotSelector(
              timeSlots: ongkirInfo.pricing!.timeSlots!,
              selectedSlot: selectedTimeSlot,
              onSlotSelected: onTimeSlotSelected ?? (_) {},
              enabled: !isLoading,
            ),
          ],

          // Show variable pricing breakdown jika ada
          if (_hasBreakdown) ...[
            Gap(8.h),
            _buildPricingBreakdown(),
          ],

          Gap(8.h),
          _buildFooterInfo(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: _getIconBackgroundColor(),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            Icons.local_shipping_outlined,
            size: 20.sp,
            color: _getIconColor(),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('DETAIL PENGIRIMAN', style: text12BlackMedium),
              if (_isFreeOngkir)
                Text(
                  'Gratis Ongkir! 🎉',
                  style: text10BlackRegular.copyWith(
                    color: kSuccessColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ),
        _buildPriceBadge(),
      ],
    );
  }

  Widget _buildDistanceInfo() {
    final distance = ongkirInfo.distance;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: kGrey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, size: 16.sp, color: kPrimaryColor),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jarak: ${distance?.text ?? "-"} (${distance?.duration ?? "-"})',
                  style: text12BlackMedium,
                ),
                Gap(2.h),
                Text(
                  'Sumber: ${_getSourceText(distance?.source)}',
                  style: text10BlackRegular.copyWith(color: kGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingInfo() {
    final pricing = ongkirInfo.pricing;
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: _isFreeOngkir
            ? kSuccessColor.withOpacity(0.05)
            : kGrey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.r),
        border: _isFreeOngkir
            ? Border.all(color: kSuccessColor.withOpacity(0.2))
            : null,
      ),
      child: Row(
        children: [
          Icon(
            _isFreeOngkir ? Icons.card_giftcard : Icons.attach_money,
            size: 16.sp,
            color: _isFreeOngkir ? kSuccessColor : kPrimaryColor,
          ),
          Gap(8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tier: ${pricing?.tierName ?? "-"}',
                  style: text12BlackMedium,
                ),
                if (!_isFreeOngkir && pricing?.rate != null) ...[
                  Gap(2.h),
                  Text(
                    'Ongkir: ${(pricing!.rate!).toString().toIdrFormat}',
                    style: text12BlackRegular.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingBreakdown() {
    final breakdown = ongkirInfo.pricing?.breakdown;
    if (breakdown == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: Colors.blue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long, size: 14.sp, color: Colors.blue),
              Gap(6.w),
              Text('Rincian Biaya:', style: text12BlackMedium),
            ],
          ),
          Gap(6.h),
          _buildBreakdownItem(
            'Biaya dasar',
            (breakdown.basePrice ?? 0).toString().toIdrFormat,
          ),
          if (breakdown.extraKm != null && breakdown.extraKm! > 0)
            _buildBreakdownItem(
              'Extra ${breakdown.extraKm} km',
              '${(breakdown.extraCharge ?? 0).toString().toIdrFormat} (${(breakdown.perKmPrice ?? 0).toString().toIdrFormat}/km)',
            ),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, top: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('• $label', style: text12BlackRegular.copyWith(color: kGrey)),
          Text(value, style: text12BlackMedium),
        ],
      ),
    );
  }

  Widget _buildFooterInfo() {
    final requireTimeSlot = ongkirInfo.pricing?.requireTimeSlot ?? false;

    if (requireTimeSlot && selectedTimeSlot == null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(Icons.info_outline, size: 14.sp, color: Colors.orange),
            Gap(8.w),
            Expanded(
              child: Text(
                'Silakan pilih waktu pengiriman untuk melanjutkan',
                style:
                    text12BlackRegular.copyWith(color: Colors.orange.shade700),
              ),
            ),
          ],
        ),
      );
    }

    if (selectedTimeSlot != null) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: kSuccessColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, size: 14.sp, color: kSuccessColor),
            Gap(8.w),
            Expanded(
              child: Text(
                'Waktu pengiriman: ${selectedTimeSlot!.name}',
                style: text12BlackRegular.copyWith(
                  color: kSuccessColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildPriceBadge() {
    final rate = ongkirInfo.pricing?.rate ?? 0;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _isFreeOngkir ? kSuccessColor : kPrimaryColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        _isFreeOngkir ? 'GRATIS' : rate.toString().toIdrFormat,
        style: text12BlackRegular.copyWith(
          color: kWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper getters
  bool get _isFreeOngkir => ongkirInfo.pricing?.isFreeOngkir == true;
  bool get _hasTimeSlots =>
      ongkirInfo.pricing?.timeSlots != null &&
      ongkirInfo.pricing!.timeSlots!.isNotEmpty;
  bool get _hasBreakdown => ongkirInfo.pricing?.breakdown != null;

  Color _getBackgroundColor() {
    if (_isFreeOngkir) return kSuccessColor.withOpacity(0.03);
    return kWhite;
  }

  Color _getBorderColor() {
    if (_isFreeOngkir) return kSuccessColor.withOpacity(0.3);
    return kBorder;
  }

  Color _getIconBackgroundColor() {
    if (_isFreeOngkir) return kSuccessColor.withOpacity(0.1);
    return kPrimaryColor.withOpacity(0.1);
  }

  Color _getIconColor() {
    if (_isFreeOngkir) return kSuccessColor;
    return kPrimaryColor;
  }

  String _getSourceText(String? source) {
    switch (source) {
      case 'google_maps':
        return 'Google Maps (Akurat)';
      case 'haversine':
        return 'Perhitungan Alternatif';
      default:
        return 'Unknown';
    }
  }
}

/// Widget untuk loading state saat check ongkir
class DeliveryInfoLoading extends StatelessWidget {
  const DeliveryInfoLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kGrey.withOpacity(0.05),
        borderRadius: AppStyle.borderRadius8All,
        border: Border.all(color: kBorder),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            height: 20.w,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          Gap(12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Menghitung ongkir...', style: text12BlackMedium),
                Gap(4.h),
                Text(
                  'Menggunakan Google Maps API untuk akurasi',
                  style: text12BlackRegular.copyWith(color: kGrey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget untuk error state
class DeliveryInfoError extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const DeliveryInfoError({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: kErrorColor.withOpacity(0.05),
        borderRadius: AppStyle.borderRadius8All,
        border: Border.all(color: kErrorColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: kErrorColor, size: 20.sp),
              Gap(12.w),
              Expanded(
                child: Text(
                  'Gagal mendapatkan info ongkir',
                  style: text12BlackRegular.copyWith(
                    color: kErrorColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            errorMessage,
            style: text12BlackRegular.copyWith(color: kGrey),
          ),
          if (onRetry != null) ...[
            Gap(12.h),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Coba Lagi'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: kPrimaryColor,
                  side: const BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
