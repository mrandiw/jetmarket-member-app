import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/komplain/section/app_bar_section.dart';
import 'package:jetmarket/presentation/komplain/section/reason_proof_section.dart';
import 'package:jetmarket/presentation/komplain/section/reason_return.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/komplain.controller.dart';
import 'section/footer_section.dart';
import 'section/product_section.dart';

class KomplainScreen extends GetView<KomplainController> {
  const KomplainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarKomplain,
      body: ListView(
        padding: AppStyle.paddingAll16,
        children: [
          const ReasonReturn(),
          const ProductSection(),
          ReasonProofSection(
            controller: controller,
          )
        ],
      ),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
