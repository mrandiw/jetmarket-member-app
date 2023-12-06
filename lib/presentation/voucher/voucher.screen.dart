import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/voucher/section/voucher_section.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../infrastructure/theme/app_text.dart';
import '../../utils/style/app_style.dart';
import 'controllers/voucher.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';

class VoucherScreen extends GetView<VoucherController> {
  const VoucherScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarVoucher,
      body: const VoucherSection(),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
