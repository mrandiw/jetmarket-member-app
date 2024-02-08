import 'dart:convert';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/order_pages/set_refund/controllers/set_refund.controller.dart';
import '../../../../domain/core/model/model_data/set_refund_model.dart';

class ChoiceDeliveryRefundController extends GetxController {
  List<Packets> packets = [];
  int? selectedServiceIndex;
  int selectedPacket = 99;

  void selectPacket(int data) {
    selectedPacket = data;
    setChoiceDelivery();
    update();
  }

  setData() {
    selectedServiceIndex = Get.arguments[0];
    List<dynamic> packet = jsonDecode(Get.arguments[1]);
    packets = packet.map((e) => Packets.fromJson(e)).toList();
  }

  void setChoiceDelivery() {
    final controller = Get.find<SetRefundController>();
    controller.updateChoiceDelivery(selectedServiceIndex ?? 0, selectedPacket);
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }
}
