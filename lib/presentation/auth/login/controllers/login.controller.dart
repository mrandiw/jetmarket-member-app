import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/utils/global/constant.dart';
import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/argument/payment_methode_argument.dart';
import '../../../../domain/core/model/params/auth/login_param.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository;
  LoginController(this._authRepository);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var actionStatus = ActionStatus.initalize;

  var isEmailValidated = false.obs;
  var isPasswordValidated = false.obs;

  Future<void> login() async {
    actionStatus = ActionStatus.loading;
    update();

    var param = LoginParam(
        email: emailController.text,
        password: passwordController.text,
        fcmToken: fcmToken);

    final response = await _authRepository.login(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      isEmployee = response.result?.user?.isEmployee ?? false;
      if (response.result?.user?.isVerified == false) {
        Get.offAllNamed(Routes.REGISTER_OTP);
      } else if (response.result?.user?.activatedAt == '0001-01-01T00:00:00Z' &&
          response.result?.trxId == null) {
        Get.offAllNamed(Routes.SUCCESS_VERIFY_OTP);
      } else if (response.result?.user?.activatedAt == '0001-01-01T00:00:00Z' &&
          response.result?.trxId != null) {
        var argument = PaymentMethodeArgument(
            trxId: AppPreference().getTrxId(), status: "waiting");
        Get.offAllNamed(Routes.DETAIL_PAYMENT_REGISTER, arguments: argument);
      } else {
        Get.offAllNamed(Routes.MAIN_PAGES);
      }
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

  listenPasswordForm(String value) {
    if (value.length >= 8) {
      isPasswordValidated(true);
    } else {
      isPasswordValidated(false);
    }
  }
}
