import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/params/auth/forgot_verify_otp_param.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class OtpController extends GetxController {
  final AuthRepository _authRepository;
  OtpController(this._authRepository);
  late List<TextEditingController> otpControllers;
  var enableButton = false;
  var actionStatus = ActionStatus.initalize;

  String email = "";

  Future<void> verifyOtp() async {
    List<String> otpNumber = [];
    for (var otp in otpControllers) {
      otpNumber.add(otp.text);
    }
    actionStatus = ActionStatus.loading;
    update();
    var param = ForgotVerifyOtpParam(email: email, otp: otpNumber.join());
    final response = await _authRepository.verifyForgotOtp(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.toNamed(Routes.RESET_PASSWORD);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  @override
  void onInit() {
    email = Get.arguments;
    super.onInit();
    otpControllers = List.generate(4, (index) {
      var controller = TextEditingController();
      controller.addListener(_checkIfAllFieldsFilled);
      return controller;
    });
    _checkIfAllFieldsFilled();
  }

  void _checkIfAllFieldsFilled() {
    bool allFilled = otpControllers.every((element) => element.text.isNotEmpty);
    enableButton = allFilled;
    update();
  }

  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
