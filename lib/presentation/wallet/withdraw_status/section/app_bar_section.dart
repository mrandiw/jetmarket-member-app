import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/withdraw_status/controllers/withdraw_status.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../../utils/assets/assets_svg.dart';

AppBar appBarWithdraw(WithdrawStatusController controller) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    toolbarHeight: 52.hr,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => controller.refreshEwalletPage(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Withdraw', style: text16BlackSemiBold),
  );
}
