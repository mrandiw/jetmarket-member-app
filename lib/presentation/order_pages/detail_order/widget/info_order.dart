import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/info_order_done.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/info_order_waiting.dart';

import '../section/info_order_cancel.dart';
import '../section/info_order_delivery.dart';

class InfoOrder extends StatelessWidget {
  const InfoOrder({super.key, required this.type});
  final int type;

  @override
  Widget build(BuildContext context) {
    if (type == 1) {
      return const InfoOrderDelivery();
    } else if (type == 2) {
      return const InfoOrderDone();
    } else if (type == 3) {
      return const InfoOrderWaiting();
    } else if (type == 4) {
      return const InfoOrderCancel();
    }
    {
      return const SizedBox();
    }
  }
}
