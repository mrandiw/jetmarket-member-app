import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_text.dart';
import '../button/app_button.dart';

class AppDialogConfirmation {
  static void show({
    required String title,
    required String message,
    String? linkUrl,
    bool enableCopyLink = true,
    String? onTesText,
    Function()? onPressed,
    bool barrierDismissible = true,
  }) {
    Get.dialog(
      PopScope(
        canPop: barrierDismissible,
        child: Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Container(
            padding: AppStyle.paddingAll16,
            decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius8All,
              color: kWhite,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 320.w, minHeight: 100.w),
              child: SingleChildScrollView(
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: text12BlackMedium),
                      Gap(6.h),
                      Text(message, style: text12HintRegular),

                      // --- Tampilkan link & tombol salin saja ---
                      if (linkUrl != null && linkUrl.trim().isNotEmpty) ...[
                        Gap(12.h),
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF7F7F8),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: const Color(0xFFE6E6E8)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(Icons.link,
                                  size: 18, color: Colors.blueGrey),
                              Gap(8.w),
                              // selectable supaya mudah block-copy manual juga
                              Expanded(
                                child: SelectableText(
                                  linkUrl,
                                  style: text12BlackMedium.copyWith(
                                    color: Colors.blueGrey.shade800,
                                  ),
                                  maxLines: 3,
                                ),
                              ),
                              if (enableCopyLink) ...[
                                Gap(8.w),
                                TextButton.icon(
                                  onPressed: () => _copyToClipboard(linkUrl),
                                  icon: const Icon(Icons.copy, size: 16),
                                  label: const Text('Salin'),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 6.h,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],

                      Gap(16.h),
                      Row(
                        children: [
                          const Spacer(),
                          if (barrierDismissible)
                            SizedBox(
                              width: Get.width * 0.24,
                              child: AppButton.secondaryGrey(
                                text: "Batal",
                                onPressed: () => Get.back(),
                              ),
                            ),
                          Gap(6.w),
                          SizedBox(
                            width: Get.width * 0.34,
                            child: AppButton.primary(
                              text: "Ya, ${onTesText ?? ''}".trim(),
                              onPressed: onPressed,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  // --- helper: salin ke clipboard ---
  static Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
    Get.rawSnackbar(message: 'Link disalin ke clipboard');
  }
}
