import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/edit_account/widget/picker_date.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../components/dialog/app_dialog_confirmation.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/network/action_status.dart';

class EditAccountController extends GetxController {
  final AuthRepository _authRepository;
  EditAccountController(this._authRepository);
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  UserModel? userData;

  var actionStatus = ActionStatus.initalize;

  var isNameValidated = false.obs;
  var isPhoneValidated = false.obs;
  var isEmailValidated = false.obs;
  var isPasswordValidated = false.obs;
  var selectedDatePicker = "";
  var datePicker = <DateTime?>[];

  final String countryCode = '+62';

  List<String> genders = ['Laki-laki', 'Perempuan'];
  int selectedGender = 0;
  String nameGender = "L";

  void selectGender(int index) {
    selectedGender = index;
    if (index == 0) {
      nameGender = "L";
    } else {
      nameGender = "P";
    }
    update();
  }

  listenNameForm(String value) {
    if (value.isNotEmpty) {
      isNameValidated(true);
    } else {
      isNameValidated(false);
    }
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
    final value = DateFormat('yyyy-MM-dd').format(parsedDate);
  }

  Future<void> deleteAccount() async {
    Get.back();
    final response = await _authRepository.deleteAccount();
    if (response.status == StatusResponse.success) {
      AppPreference().clearOnLogout();
      Get.offAllNamed(Routes.LOGIN);
    } else {
      AwesomeDialog(
              context: Get.context!,
              dialogType: DialogType.error,
              animType: AnimType.rightSlide,
              title: 'Error',
              desc: response.message,
              titleTextStyle: text16BlackSemiBold,
              descTextStyle: text12BlackRegular,
              btnCancelOnPress: () {})
          .show();
    }
  }

  void confirmationDelete() {
    AppDialogConfirmation.show(
      title: 'Hapus Akun',
      message:
          'Menghapus akun berarti data Anda tidak dapat dikembalikan. Yakin ingin menghapus akun?',
      onTesText: 'Hapus',
      onPressed: () => deleteAccount(),
    );
  }

  @override
  void onInit() {
    userData = Get.arguments;
    phoneController.text = countryCode;
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    super.onInit();
  }
}
