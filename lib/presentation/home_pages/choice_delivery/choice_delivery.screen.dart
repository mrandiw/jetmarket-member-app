import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/section/app_bar_section.dart';

import 'controllers/choice_delivery.controller.dart';
import 'section/list_packet.dart';

class ChoiceDeliveryScreen extends GetView<ChoiceDeliveryController> {
  const ChoiceDeliveryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarChoiceDelivery(controller),
      body: ListPacket(
        controller: controller,
      ),
    );
  }
}
