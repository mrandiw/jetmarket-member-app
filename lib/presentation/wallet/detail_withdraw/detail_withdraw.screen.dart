import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/section/app_bar_section.dart';
import 'package:jetmarket/presentation/wallet/detail_withdraw/section/detail_wd.dart';

import 'controllers/detail_withdraw.controller.dart';

class DetailWithdrawScreen extends GetView<DetailWithdrawController> {
  const DetailWithdrawScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBarDetailWithdraw, body: const DetailWd());
  }
}
