import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/choice_delivery_refund.controller.dart';
import 'section/app_bar_section.dart';
import 'section/list_packet.dart';

class ChoiceDeliveryRefundScreen
    extends GetView<ChoiceDeliveryRefundController> {
  const ChoiceDeliveryRefundScreen({super.key});
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
