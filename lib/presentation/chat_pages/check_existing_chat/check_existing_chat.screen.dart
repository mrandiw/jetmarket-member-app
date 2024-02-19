import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/components/loading/load_pages.dart';

import 'controllers/check_existing_chat.controller.dart';

class CheckExistingChatScreen extends GetView<CheckExistingChatController> {
  const CheckExistingChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const LoadingPages();
  }
}
