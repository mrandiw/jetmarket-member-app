import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import 'package:jetmarket/main.dart';

import '../../../infrastructure/theme/app_colors.dart';

enum SnackType { success, error, dark }

class AppSnackbar {
  static void show(
      {String? message,
      SnackType type = SnackType.success,
      bool onTop = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final messenger = rootScaffoldMessengerKey.currentState;
      if (messenger == null) {
        return;
      }

      messenger
        ..clearSnackBars()
        ..clearMaterialBanners();

      final text = message == null || message == "" ? "Error not define" : message;
      final backgroundColor = type == SnackType.success
          ? kSuccessColor
          : type == SnackType.dark
              ? kBlack
              : kErrorColor;

      if (onTop) {
        messenger.showMaterialBanner(
          MaterialBanner(
            backgroundColor: backgroundColor,
            forceActionsBelow: false,
            padding:
                type == SnackType.dark ? AppStyle.paddingAll8 : AppStyle.paddingAll16,
            content: Row(
              children: [
                if (type != SnackType.dark) ...[
                  Icon(
                    type == SnackType.success
                        ? Icons.check_circle_rounded
                        : Icons.close,
                    color: Colors.white,
                    size: 18.r,
                  ),
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(text, style: const TextStyle(color: Colors.white)),
                ),
              ],
            ),
            actions: const [SizedBox.shrink()],
          ),
        );

        Future.delayed(const Duration(seconds: 2), () {
          messenger.clearMaterialBanners();
        });
        return;
      }

      messenger.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: backgroundColor,
          duration: const Duration(seconds: 2),
          margin: type == SnackType.dark
              ? EdgeInsets.symmetric(vertical: 82.h, horizontal: 46.w)
              : EdgeInsets.all(16.r),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (type != SnackType.dark) ...[
                Icon(
                  type == SnackType.success
                      ? Icons.check_circle_rounded
                      : Icons.close,
                  color: Colors.white,
                  size: 18.r,
                ),
                SizedBox(width: 8.w),
              ],
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          padding:
              type == SnackType.dark ? AppStyle.paddingAll8 : AppStyle.paddingAll16,
        ),
      );
    });
  }
}
