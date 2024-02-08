import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar get appBarTrackingOrder {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Lacak Pengiriman', style: text16BlackSemiBold),
  );
}
