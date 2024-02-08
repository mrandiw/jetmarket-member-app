import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/controllers/choice_delivery.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

AppBar appBarChoiceDelivery(ChoiceDeliveryController controller) {
  return AppBar(
      backgroundColor: kWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(arrowForward),
      ),
      title: Text(
          'Pilih Pengirima ${controller.packets.first.name?.toUpperCase()}',
          style: text16BlackSemiBold));
}
