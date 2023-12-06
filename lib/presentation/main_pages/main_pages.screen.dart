import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../utils/assets/assets_svg.dart';
import 'controllers/main_pages.controller.dart';

class MainPagesScreen extends GetView<MainPagesController> {
  const MainPagesScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: controller.listPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex,
            onTap: controller.changeTabIndex,
            backgroundColor: kWhite,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kSoftGrey,
            selectedLabelStyle: text11PrimaryRegular,
            unselectedLabelStyle: text11HintRegular,
            type: BottomNavigationBarType.fixed,
            items: [
              _itemButtom(
                  icon: home, iconFill: homeFill, label: "Home", index: 0),
              _itemButtom(
                  icon: pesanan,
                  iconFill: pesananFill,
                  label: "Pesanan",
                  index: 1),
              _itemButtom(
                  icon: koperasi,
                  iconFill: koperasiFill,
                  label: "Koperasi",
                  index: 2),
              _itemButtom(
                  icon: wallet, iconFill: wallet, label: "E-Wallet", index: 3),
              _itemButtom(icon: akun, iconFill: akun, label: "Akun", index: 4),
            ]),
      );
    });
  }

  BottomNavigationBarItem _itemButtom(
      {required String icon,
      required String iconFill,
      String? label,
      required int index}) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          controller.selectedIndex == index ? iconFill : icon,
        ),
        label: label);
  }
}
