import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class ResetPasswordController extends GetxController {
  final AuthRepository _authRepository;
  ResetPasswordController(this._authRepository);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController konfirmasiPasswordController = TextEditingController();

  var actionStatus = ActionStatus.initalize;
  final formKey = GlobalKey<FormState>();

  var isPasswordValidated = false.obs;
  var isKonfirmasiPasswordValidated = false.obs;
  String valuePassword = '';
  String valuekonfirmasiPassword = '';

  listenKonfirmasiPasswordForm(String value) {
    valuekonfirmasiPassword = value;
    update();
    if (value.length >= 8) {
      isKonfirmasiPasswordValidated(true);
    } else {
      isKonfirmasiPasswordValidated(false);
    }
  }

  listenPasswordForm(String value) {
    valuePassword = value;
    update();
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
      AppPreference().clearAccessToken();
      Get.offNamedUntil(
          Routes.RESET_SUCESS, (route) => route.settings.name == Routes.LOGIN);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  passwordValidator(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    } else if (value.length < 8) {
      return "Password minimal 8 karakter";
    } else {
      return null;
    }
  }

  passwordCaonfirmationValidator(String value) {
    if (value.isEmpty) {
      return "Password tidak boleh kosong";
    } else if (value.length < 8) {
      return "Password minimal 8 karakter";
    } else if (valuekonfirmasiPassword != valuePassword) {
      return "Password tidak sama";
    } else {
      return null;
    }
  }
}
