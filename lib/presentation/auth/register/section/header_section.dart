import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../utils/assets/assets_images.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 302.hr,
      width: Get.width.wr,
      color: kPrimaryColor2,
      child: Image.asset(
        authImage,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
