import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

class LoadingPages extends StatelessWidget {
  const LoadingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
      child: const Center(
          child: CircularProgressIndicator(
        color: kPrimaryColor,
      )),
    );
  }
}
