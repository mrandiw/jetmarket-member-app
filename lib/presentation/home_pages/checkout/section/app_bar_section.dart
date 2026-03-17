import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

void _handleBackCheckout() {
  final navigator = Get.key.currentState;
  if (navigator?.canPop() ?? false) {
    navigator?.pop();
    return;
  }

  Get.offNamed(Routes.CART);
}

AppBar get appBarCheckout {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0,
    automaticallyImplyLeading: false,
    leading: const IconButton(
      onPressed: _handleBackCheckout,
      icon: Icon(Icons.arrow_back_ios_new_rounded, color: kBlack),
    ),
    title: Text('Checkout', style: text16BlackSemiBold),
  );
}
