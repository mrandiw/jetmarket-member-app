import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/params/auth/register_virify_otp_param.dart';
import 'package:jetmarket/presentation/auth/register/controllers/register.controller.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/app_preference/app_preferences.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class RegisterOtpController extends GetxController {
  final AuthRepository _authRepository;
  RegisterOtpController(this._authRepository);
  late List<TextEditingController> otpControllers;
  var enableButton = false;
  var actionStatus = ActionStatus.initalize;

  String phoneNumber = "";

  Future<void> verifyOtp() async {
    List<String> otpNumber = [];
    for (var otp in otpControllers) {
      otpNumber.add(otp.text);
    }
    actionStatus = ActionStatus.loading;
    update();
    var param =
        RegisterVerifyOtpParam(email: phoneNumber, otp: otpNumber.join());
    final response = await _authRepository.verifyRegisterOtp(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      AppPreference().verifySuccess();
      update();
      Get.toNamed(Routes.SUCCESS_VERIFY_OTP);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      if (response.message == 'Kode OTP telah Kadaluarsa!') {
        _authRepository.sendRegisterOtp(phoneNumber);
        if (response.status == StatusResponse.success) {
          for (var item in otpControllers) {
            item.clear();
          }
          AppSnackbar.show(
              message:
                  'Kode OTP Telah Kadaluarsa, Kode otp baru telah terkirim ke email!',
              type: SnackType.success);
        }
      } else {
        AppSnackbar.show(
            message: response.message ?? '', type: SnackType.error);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    phoneNumber = Get.arguments;
    otpControllers = List.generate(6, (index) {
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
