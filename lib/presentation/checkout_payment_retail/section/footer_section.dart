import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/auth/detail_payment_register/controllers/detail_payment_register.controller.dart';
import 'package:jetmarket/presentation/checkout_payment/controllers/checkout_payment.controller.dart';
import 'package:jetmarket/presentation/checkout_payment_retail/controllers/checkout_payment_retail.controller.dart';
import 'package:jetmarket/presentation/choice_payment/controllers/choice_payment.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key, required this.controller});

  final CheckoutPaymentRetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76.h,
      width: Get.width,
      padding: AppStyle.paddingAll16,
      decoration: BoxDecoration(color: kWhite, boxShadow: [
        BoxShadow(
            color: const Color(0xffE3BEBD).withOpacity(0.08),
            offset: const Offset(0, -6),
            blurRadius: 10)
      ]),
      child: AppButton.primary(
        text: 'Back to Merchant',
        onPressed: () => controller.toMerchenPage(),
      ),
    );
  }
}
