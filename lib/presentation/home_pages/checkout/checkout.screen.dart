import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';

import '../../../infrastructure/theme/app_colors.dart';
import 'controllers/checkout.controller.dart';
import 'section/address_section.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';
import 'section/product_section.dart';
import 'section/voucher_section.dart';

class CheckoutScreen extends GetView<CheckoutController> {
  const CheckoutScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingCheck.value) {
        return const LoadingPages();
      } else {
        return Scaffold(
          backgroundColor: kWhite,
          appBar: appBarCheckout,
          body: ListView(
            children: const [
              AddressSection(),
              ProductSection(),
              VoucherSection()
            ],
          ),
          bottomNavigationBar: const FooterSection(),
        );
      }
    });
  }
}
