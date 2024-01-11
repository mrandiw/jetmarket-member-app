import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar appBarDetailOrder(DetailOrderController controller) {
  return AppBar(
    backgroundColor: kWhite,
    elevation: 0.3,
    automaticallyImplyLeading: false,
    leading: IconButton(
      onPressed: () => controller.backToOrder(),
      icon: SvgPicture.asset(arrowForward),
    ),
    title: Text('Detail Order', style: text16BlackSemiBold),
  );
}
