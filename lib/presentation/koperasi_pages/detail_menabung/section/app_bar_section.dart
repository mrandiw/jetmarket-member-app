import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

import '../controllers/detail_menabung.controller.dart';

AppBar appBarDetailSaving(DetailMenabungController controller) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => controller.actionBack(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Detail Simpanan', style: text16BlackSemiBold),
  );
}
