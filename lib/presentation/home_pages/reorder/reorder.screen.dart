import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';

import 'controllers/reorder.controller.dart';

class ReorderScreen extends GetView<ReorderController> {
  const ReorderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const LoadingPages();
  }
}
