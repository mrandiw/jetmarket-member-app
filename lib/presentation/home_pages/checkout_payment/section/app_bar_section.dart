import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/checkout_payment/controllers/checkout_payment.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar appBarPaymentOrder(CheckoutPaymentController controller) {
  return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => controller.backtoMerchent(),
        icon: SvgPicture.asset(arrowForward),
      ),
      title: Text('Pembayaran', style: text16BlackSemiBold));
}
