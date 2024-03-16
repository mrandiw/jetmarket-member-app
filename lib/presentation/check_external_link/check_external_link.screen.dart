import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';
import '../../infrastructure/theme/app_colors.dart';
import 'controllers/check_external_link.controller.dart';

class CheckExternalLinkScreen extends GetView<CheckExternalLinkController> {
  const CheckExternalLinkScreen({super.key});
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteBackground,
        body: FutureBuilder(
            future: controller.checkingAuth(),
            builder: (_, snap) {
              return const LoadingPages();
            }));
  }
}
