import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository;
  ForgotPasswordController(this._authRepository);
  TextEditingController emailController = TextEditingController();

  var actionStatus = ActionStatus.initalize;

  var isEmailValidated = false.obs;

  Future<void> nextToSendOtp() async {
    actionStatus = ActionStatus.loading;
    update();

    final response = await _authRepository.sendOtp(emailController.text);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.toNamed(Routes.OTP, arguments: emailController.text);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  void listenEmailForm(String value) {
    if (value.isNotEmpty) {
      if (validateEmail(value)) {
        isEmailValidated(true);
      } else {
        isEmailValidated(false);
      }
    } else {
      isEmailValidated(false);
    }
  }

  bool validateEmail(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }
}
