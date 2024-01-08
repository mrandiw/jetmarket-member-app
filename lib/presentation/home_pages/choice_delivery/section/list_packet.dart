import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/controllers/choice_delivery.controller.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/widget/packet_item.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ListPacket extends StatelessWidget {
  const ListPacket({super.key, required this.controller});
  final ChoiceDeliveryController controller;

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
