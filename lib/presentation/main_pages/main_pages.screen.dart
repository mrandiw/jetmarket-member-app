import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/main_pages/controllers/item_bar_model.dart';
import '../screens.dart';
import 'controllers/main_pages.controller.dart';

class MainPagesScreen extends GetView<MainPagesController> {
  const MainPagesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: controller.isEmployee
              ? controller.listPageIsEmploye
              : controller.listPageNotIsEmploye,
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
            items: List.generate(
                controller.listItemBar.length,
                (index) => _itemButtom(
                    item: controller.listItemBar[index], index: index))),
      );
    });
  }

  BottomNavigationBarItem _itemButtom(
      {required ItemBarModel item, required int index}) {
    return BottomNavigationBarItem(
        icon: SvgPicture.asset(
          controller.selectedIndex == index ? item.iconFill : item.icon,
        ),
        label: item.label);
  }
}
