import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/cara_bayar/controllers/cara_bayar.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../widget/paymen_type.dart';

class DetailSection extends StatelessWidget {
  const DetailSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CaraBayarController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentType(type: controller.methodeType, controller: controller)
            ],
          ),
        ),
      );
    });
  }
}
