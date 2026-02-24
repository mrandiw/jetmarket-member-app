import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DialogType { error, success }

enum AnimType { rightSlide }

class AwesomeDialog {
  final BuildContext context;
  final DialogType dialogType;
  final AnimType? animType;
  final String? title;
  final String? desc;
  final TextStyle? titleTextStyle;
  final TextStyle? descTextStyle;
  final VoidCallback? btnOkOnPress;
  final VoidCallback? btnCancelOnPress;
  final String? btnOkText;
  final String? btnCancelText;
  final bool? dismissOnTouchOutside;

  AwesomeDialog({
    required this.context,
    required this.dialogType,
    this.animType,
    this.title,
    this.desc,
    this.titleTextStyle,
    this.descTextStyle,
    this.btnOkOnPress,
    this.btnCancelOnPress,
    this.btnOkText,
    this.btnCancelText,
    this.dismissOnTouchOutside,
  });

  Future<T?> show<T>() {
    final String effectiveTitle = title ?? '';
    final String effectiveDesc = desc ?? '';
    final String cancelLabel = btnCancelText ?? 'OK';
    final String okLabel = btnOkText ?? 'OK';

    return Get.dialog<T>(
      AlertDialog(
        title: Text(
          effectiveTitle,
          style: titleTextStyle,
        ),
        content: Text(
          effectiveDesc,
          style: descTextStyle,
        ),
        actions: [
          if (btnCancelOnPress != null || btnCancelText != null)
            TextButton(
              onPressed: () {
                Get.back();
                btnCancelOnPress?.call();
              },
              child: Text(cancelLabel),
            ),
          if (btnOkOnPress != null || btnOkText != null)
            TextButton(
              onPressed: () {
                Get.back();
                btnOkOnPress?.call();
              },
              child: Text(okLabel),
            ),
        ],
      ),
      barrierDismissible: dismissOnTouchOutside ?? false,
    );
  }
}
