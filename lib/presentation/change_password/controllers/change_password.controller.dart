import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/snackbar/app_snackbar.dart';
import '../../../domain/core/interfaces/auth_repository.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/network/action_status.dart';
import '../../../utils/network/status_response.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository;
  ChangePasswordController(this._authRepository);
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();

  var actionStatus = ActionStatus.initalize;

  var isPasswordValidated = false.obs;
  var isKonfirmasiPasswordValidated = false.obs;

  listenKonfirmasiPasswordForm(String value) {
    if (value.length >= 8) {
      isKonfirmasiPasswordValidated(true);
    } else {
      isKonfirmasiPasswordValidated(false);
    }
  }

  listenPasswordForm(String value) {
    if (value.length >= 8) {
      isPasswordValidated(true);
    } else {
      isPasswordValidated(false);
    }
  }

  Future<void> resetPassword() async {
    actionStatus = ActionStatus.loading;
    update();

    final response = await _authRepository.reset(passwordController.text);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.offNamedUntil(Routes.SUCCESS_CHANGE_PASSWORD,
          (route) => route.settings.name == Routes.EDIT_ACCOUNT);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }
}
