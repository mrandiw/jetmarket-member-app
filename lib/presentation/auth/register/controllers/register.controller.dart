import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';

import '../../../../components/snackbar/app_snackbar.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/params/auth/register_param.dart';
import '../../../../utils/global/constant.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';
import '../widget/picker_date.dart';

class RegisterController extends GetxController {
  final AuthRepository _authRepository;
  RegisterController(this._authRepository);
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final FocusNode focusNodeReferral = FocusNode();

  var actionStatus = ActionStatus.initalize;
  var actionClaimStatus = ActionStatus.initalize;

  var isNameValidated = false.obs;
  var isPhoneValidated = false.obs;
  var isEmailValidated = false.obs;
  var isPasswordValidated = false.obs;
  var isKodeReveralValidated = false.obs;
  var isKodeReveralError = false.obs;
  bool isNameError = false;

  final String countryCode = '+62';
  var referralMessage = ''.obs;
  var selectedDatePicker = "";
  var selectedBirtDay = "";

  var datePicker = <DateTime?>[];

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
        birthDate: selectedBirtDay,
        email: emailController.text,
        password: passwordController.text,
        kodeReferall:
            isKodeReveralValidated.value ? referralController.text : null,
        fcmToken: fcmToken);

    final response = await _authRepository.register(param);

    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;

      update();
      if (isKodeReveralValidated.value) {
        AppPreference().referalSuccess();
      } else {}
      Get.offAllNamed(Routes.REGISTER_OTP);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message ?? '', type: SnackType.error);
    }
  }

  listenNameForm(String value) {
    if (value.isNotEmpty) {
      final RegExp nameExp = RegExp(r'^[a-zA-Z ]{2,20}$');

      if (value.length > 20) {
        isNameError = true;
        update();
      } else if (!nameExp.hasMatch(value)) {
        isNameError = true;
        update();
      } else {
        isNameError = false;
        update();
        isNameValidated(true);
      }
    } else {
      isNameValidated(false);
    }
  }

  String? validatorName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }

    final RegExp nameExp = RegExp(r'^[a-zA-Z]{2,10}( [a-zA-Z]{2,10})+$');

    if (!nameExp.hasMatch(value)) {
      return 'Please enter a valid name';
    }

    return null;
  }

  listenPhoneForm(String value) {
    if (value.startsWith('${countryCode}0') &&
        value.length > (countryCode.length + 1)) {
      phoneController.text =
          countryCode + value.substring(countryCode.length + 1);
      phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: phoneController.text.length));
      update();
    }
    if (value.length >= 6) {
      isPhoneValidated(true);
    } else {
      isPhoneValidated(false);
    }
  }

  List<TextInputFormatter> formaterNumber() => [
        LengthLimitingTextInputFormatter(countryCode.length + 12),
        FilteringTextInputFormatter.deny(RegExp(r'[^\d+]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.startsWith(countryCode)) {
            return newValue;
          }
          return oldValue;
        }),
      ];

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

  void openCalendarView() {
    CustomBottomSheet.show(child: PickerDate(controller: this));
  }

  pickDate(List<DateTime?> date) {
    selectedDatePicker = DateFormat('dd-MM-yyyy').format(date[0]!);
    datePicker = date;
    DateTime parsedDate = DateTime.parse("${datePicker.first}");
    // ignore: unused_local_variable
    selectedBirtDay = DateFormat('yyyy-MM-dd').format(parsedDate);
    update();
  }

  Future<void> checkReferralCode() async {
    actionClaimStatus = ActionStatus.loading;
    update();
    final response =
        await _authRepository.claimReferral(referralController.text);
    if (response.status == StatusResponse.success) {
      referralMessage.value = response.result ?? '';
      update();
      isKodeReveralValidated(true);
      actionClaimStatus = ActionStatus.success;
      update();
    } else {
      referralMessage.value = 'Kode tidak ditemukan';
      isKodeReveralError(true);
      actionClaimStatus = ActionStatus.failed;
      update();
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

  @override
  void onInit() {
    phoneController.text = countryCode;
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    if (Get.arguments != null) {
      referralController = TextEditingController(text: '${Get.arguments}');
      deeplinkArgument = null;
    }
    // focusNodeReferral.addListener(() {
    //   if (!focusNodeReferral.hasFocus) {
    //     checkReferralCode();
    //   }
    // });
    super.onInit();
  }
}
