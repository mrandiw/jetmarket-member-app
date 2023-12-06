import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar get appBarCheckout {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0.3,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Checkout', style: text16BlackSemiBold),
    actions: [
      IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.notifications,
            color: kSoftGrey,
          ))
    ],
  );
}
