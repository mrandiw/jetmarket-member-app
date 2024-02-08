import 'package:flutter/material.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

AppBar get appBarDetailWithdraw {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    toolbarHeight: 52.hr,
    title: Text('Detail Withdraw', style: text16BlackSemiBold),
  );
}
