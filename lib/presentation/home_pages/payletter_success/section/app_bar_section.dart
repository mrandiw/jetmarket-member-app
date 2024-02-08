import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';

import '../../../../utils/assets/assets_svg.dart';

AppBar get appBarSuccessPayletter {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: SvgPicture.asset(arrowForward),
    ),
  );
}
