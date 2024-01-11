import 'package:flutter/material.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../controllers/choice_delivery_refund.controller.dart';
import '../widget/packet_item.dart';

class ListPacket extends StatelessWidget {
  const ListPacket({super.key, required this.controller});
  final ChoiceDeliveryRefundController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          children: List.generate(
              controller.packets.length,
              (index) => PacketItem(
                    index: index,
                    data: controller.packets[index],
                    onTap: () => controller.selectPacket(index),
                  )),
        ),
      ),
    ));
  }
}
