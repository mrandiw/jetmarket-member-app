import 'package:flutter/material.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/section/info_order_done.dart';

import '../section/info_order_cancel.dart';
import '../section/info_order_delivery.dart';

class InfoOrder extends StatelessWidget {
  const InfoOrder({super.key, required this.status});
  final String status;

  @override
  Widget build(BuildContext context) {
    if (status == "delivery") {
      return const InfoOrderDelivery();
    } else if (status == "done") {
      return const InfoOrderDone();
    } else {
      return const InfoOrderCancel();
    }
  }
}
