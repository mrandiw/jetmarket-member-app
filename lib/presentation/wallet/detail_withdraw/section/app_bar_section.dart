import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../../../utils/assets/assets_svg.dart';
import '../controllers/detail_withdraw.controller.dart';

AppBar appBarDetailWithdraw(DetailWithdrawController controller) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => controller.actionBack(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Detail Withdraw', style: text16BlackSemiBold),
  );
}
