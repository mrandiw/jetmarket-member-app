import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../infrastructure/theme/app_colors.dart';
import '../../utils/assets/assets_images.dart';
import 'controllers/check_external_link.controller.dart';

class CheckExternalLinkScreen extends GetView<CheckExternalLinkController> {
  const CheckExternalLinkScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackground,
      body: FutureBuilder(
          future: controller.checkingAuth(),
          builder: (context, snap) {
            return Center(child: Image.asset(logo));
          }),
    );
  }
}
