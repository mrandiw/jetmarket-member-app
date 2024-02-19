import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/komplain/section/app_bar_section.dart';
import 'package:jetmarket/presentation/order_pages/komplain/section/reason_proof_section.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../components/loading/load_pages.dart';
import '../../../components/parent/parent_scaffold.dart';
import 'controllers/komplain.controller.dart';
import 'section/choice_solution.dart';
import 'section/footer_section.dart';
import 'section/product_section.dart';

class KomplainScreen extends GetView<KomplainController> {
  const KomplainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ParentScaffold(
        onSuccess: successWidget(controller),
        onLoading: const LoadingPages(),
        onError: const SizedBox.shrink(),
        onTimeout: const SizedBox.shrink(),
        status: controller.screenStatus.value,
      );
    });
  }

  Scaffold successWidget(KomplainController controller) {
    return Scaffold(
      appBar: appBarKomplain,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: [
          const ProductSection(),
          ReasonProofSection(
            controller: controller,
          ),
          const ChoiceSolution()
        ],
      ),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
