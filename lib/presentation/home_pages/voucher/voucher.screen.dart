import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home_pages/voucher/section/voucher_section.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'controllers/voucher.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';

class VoucherScreen extends GetView<VoucherController> {
  const VoucherScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.updateSelectedVoucer();
        return true;
      },
      child: Scaffold(
        backgroundColor: kWhite,
        body: CustomScrollView(
          slivers: [
            const AppBarVoucher(),
            VoucherSection(controller: controller),
            SliverToBoxAdapter(
              child: Gap(180.hr),
            )
          ],
        ),
        bottomSheet: const FooterSection(),
      ),
    );
  }
}
