import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import '../../../infrastructure/theme/app_text.dart';

class AppDialogUpdateVersion {
  static void show({
    required String title,
    required String message,
    required String playStoreUrl,
    bool barrierDismissible = true,
    Function()? onPressed,
  }) {
    Get.dialog(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.fromLTRB(18.w, 22.h, 18.w, 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              color: kWhite,
              boxShadow: [
                BoxShadow(
                  color: kSoftBlack.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _DialogIllustration(),
                Gap(12.h),
                Text(title,
                    textAlign: TextAlign.center, style: text16BlackSemiBold),
                Gap(6.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: text12HintRegular,
                ),
                Gap(12.h),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3C4),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 26.r,
                        width: 26.r,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD46B),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: const Icon(Icons.warning_amber_rounded,
                            color: Color(0xFF8A5B00), size: 18),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: Text(
                          'Pembaruan diperlukan untuk melanjutkan',
                          style: text12BlackMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(10.h),
                Text(
                  'Klik tombol di bawah untuk memperbarui ke versi terbaru di Google Play Store.',
                  textAlign: TextAlign.center,
                  style: text12HintRegular,
                ),
                Gap(20.h),
                Tooltip(
                  message: playStoreUrl,
                  child: _GooglePlayBadge(
                    onTap: onPressed,
                    label: 'Google Play',
                  ),
                ),
                Gap(15.h),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }
}

class _DialogIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 86.r,
          width: 86.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFE9F4FF), Color(0xFFFBE7FF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        Container(
          height: 72.r,
          width: 72.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFB9E3FF), Color(0xFFFFC7E8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.shopping_bag_rounded,
              color: Color(0xFF2B6CB0), size: 34),
        ),
        Positioned(
          right: 4.w,
          top: 2.h,
          child: Container(
            height: 22.r,
            width: 22.r,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5A5F),
              borderRadius: BorderRadius.circular(11.r),
              border: Border.all(color: kWhite, width: 2),
            ),
            child: const Center(
              child: Text('!',
                  style: TextStyle(
                    color: kWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class _GooglePlayBadge extends StatelessWidget {
  const _GooglePlayBadge({
    required this.onTap,
    required this.label,
  });

  final Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: const Color(0xFFE6E6E8)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 22.r,
              width: 22.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: const Color(0xFFEEF5FF),
              ),
              child: const Icon(Icons.play_arrow_rounded,
                  color: Color(0xFF2F7BF6), size: 18),
            ),
            Gap(8.w),
            Text(label, style: text12BlackMedium),
          ],
        ),
      ),
    );
  }
}
