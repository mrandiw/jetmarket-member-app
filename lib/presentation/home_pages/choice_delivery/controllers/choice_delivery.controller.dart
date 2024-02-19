import 'dart:convert';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';

import '../../../../domain/core/model/model_data/select_delivery.dart';

class ChoiceDeliveryController extends GetxController {
  int sellerId = 0;
  List<Packets> packets = [];
  int selectedPacket = 99;

  void selectPacket(int data) {
    selectedPacket = data;
    setChoiceDelivery();
    update();
  }

  setData() {
    sellerId = Get.arguments[0];
    List<dynamic> packet = jsonDecode(Get.arguments[1]);
    packets = packet.map((e) => Packets.fromJson(e)).toList();
  }

  void setChoiceDelivery() {
    final controller = Get.find<CheckoutController>();
    var selectedDelivery =
        SelectDelivery(sellerId: sellerId, packets: packets[selectedPacket]);
    controller.updateDeliverySelected(
        sellerId: sellerId,
        delivery: selectedDelivery,
        index: Get.arguments[2]);
  }

  @override
  void onInit() {
    setData();
    super.onInit();
  }
}
