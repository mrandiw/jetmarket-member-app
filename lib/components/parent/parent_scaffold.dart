import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import '../../../utils/network/screen_status.dart';

class ParentScaffold extends StatelessWidget {
  const ParentScaffold(
      {super.key,
      required this.onLoading,
      required this.onError,
      required this.onSuccess,
      required this.status,
      this.onTimeout});

  final ScreenStatus status;
  final Widget onLoading;
  final Widget onError;
  final Widget onSuccess;
  final Widget? onTimeout;

  @override
  Widget build(BuildContext context) {
    if (status == ScreenStatus.loading) {
      return onLoading;
    } else if (status == ScreenStatus.failed) {
      return onError;
    } else if (status == ScreenStatus.success) {
      return onSuccess;
    } else if (status == ScreenStatus.timeout) {
      return Material(
        color: kWhite,
        child: onTimeout ??
            Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
              child: Center(
                  child: Text(
                "Timeout",
                style: text14BlackMedium,
              )),
            ),
      );
    } else {
      return const SizedBox();
    }
  }
}
