import 'package:get/get.dart';

enum StatusWdType { success, failed }

class DetailWithdrawController extends GetxController {
  var statusWd = StatusWdType.failed;

  final count = 0.obs;

  void increment() => count.value++;
}
