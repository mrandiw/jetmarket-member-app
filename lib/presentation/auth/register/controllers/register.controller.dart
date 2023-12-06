import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/params/auth/register_param.dart';
import '../../../../utils/global/constant.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository);
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  var actionStatus = ActionStatus.initalize;

  var isNameValidated = false.obs;
  var isPhoneValidated = false.obs;
  var isEmailValidated = false.obs;
  var isPasswordValidated = false.obs;
  var isKodeReveralValidated = false.obs;

  List<String> genders = ['Laki-laki', 'Perempuan'];
  int selectedGender = 0;
  String nameGender = "L";
  var selectedPaymentMethode = "".obs;

  void selectGender(int index) {
    selectedGender = index;
    if (index == 0) {
      nameGender = "L";
    } else {
      nameGender = "P";
    }
    update();
  }

  Future<void> register() async {
    actionStatus = ActionStatus.loading;
    update();

    var param = RegisterParam(
        nama: namaController.text,
        gender: nameGender,
        phone: phoneController.text,
        email: emailController.text,
        password: passwordController.text,
        kodeReferall: referralController.text,
        fcmToken: fcmToken);

    final response = await _authRepository.register(param);

    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      AppPreference().registerSuccess();
      update();
      Get.toNamed(Routes.REGISTER_OTP, arguments: emailController.text);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  Future<void> nextToSendOtp() async {
    actionStatus = ActionStatus.loading;
    update();

    final response =
        await _authRepository.sendRegisterOtp(phoneController.text);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.toNamed(Routes.REGISTER_OTP, arguments: phoneController.text);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  listenNameForm(String value) {
    if (value.isNotEmpty) {
      isNameValidated(true);
    } else {
      isNameValidated(false);
    }
  }

  listenPhoneForm(String value) {
    if (value.isNotEmpty) {
      isPhoneValidated(true);
    } else {
      isPhoneValidated(false);
    }
  }

  listenEmailForm(String value) {
    if (value.isNotEmpty) {
      isEmailValidated(true);
    } else {
      isEmailValidated(false);
    }
  }

  listenPasswordForm(String value) {
    if (value.length > 4) {
      isPasswordValidated(true);
    } else {
      isPasswordValidated(false);
    }
  }

  listenKodeReveralForm(String value) {
    if (value.isNotEmpty) {
      isKodeReveralValidated(true);
    } else {
      isKodeReveralValidated(false);
    }
  }

  void toNextPayment() {
    Get.toNamed(Routes.PAYMENT_REGISTER);
  }

  void payAndRegister() async {
    actionStatus = ActionStatus.loading;
    update();
    await Future.delayed(2.seconds, () {
      actionStatus = ActionStatus.success;
      update();
      Get.toNamed(Routes.PAYMENT_STATUS);
    });
  }
}
