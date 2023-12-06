import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';

import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteBackground,
        body: FutureBuilder(
            future: controller.start(),
            builder: (_, snap) {
              return Center(child: Image.asset(logo));
            }));
  }
}
