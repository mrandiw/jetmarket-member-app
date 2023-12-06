import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/home/section/app_bar_section.dart';

import 'controllers/home.controller.dart';
import 'section/product_section.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarHome,
        backgroundColor: kWhite,
        body: SafeArea(
            child: RefreshIndicator(
                color: kPrimaryColor,
                onRefresh: () => controller.refreshData(),
                child: ListView(children: const [ProductSection()]))));
  }
}
