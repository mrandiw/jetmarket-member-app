import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';
import 'package:jetmarket/domain/core/model/params/auth/profile_body.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/account_pages/account/controllers/account.controller.dart';
import 'package:jetmarket/presentation/account_pages/edit_account/widget/picker_date.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/dialog/app_dialog_confirmation.dart';
import '../../../../domain/core/model/model_data/user_profile.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';

class EditAccountController extends GetxController {
  final AuthRepository _authRepository;
  EditAccountController(this._authRepository);
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  UserProfile? userData;
  String? imageUrl;

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

  String? imagesUser;
  File? userFile;
  Future getImageMenu() async {
    Get.back();
    final sharedPref = await SharedPreferences.getInstance();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.camera, imageQuality: 30);

    imagesUser = imagePicked1!.path;
    await sharedPref.setString('foto', imagesUser ?? '');
    userFile = File(imagePicked1.path);
    imageUrl = null;

    update();
    final urlImage =
        await uploadFile(userData?.name ?? '', userFile?.path ?? '');
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
    }
  }

  Future getImageGalery() async {
    Get.back();
    final sharedPref = await SharedPreferences.getInstance();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.gallery, imageQuality: 30);

    imagesUser = imagePicked1!.path;
    await sharedPref.setString('foto', imagesUser ?? '');
    userFile = File(imagePicked1.path);
    imageUrl = null;
    update();
    final urlImage = await uploadFile(userData?.name ?? '', imagePicked1.path);
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
    }
  }

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
    update();
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

  setValueForm() {
    namaController.text = userData?.name ?? '';
    selectedGender = userData?.gender == 'L' ? 0 : 1;
    phoneController.text = userData?.phone ?? '';
    emailController.text = userData?.email ?? '';
    selectedDatePicker = userData?.birthDate ?? '';
    imageUrl = userData?.image ?? '';
    passwordController.text = '12345678';
    update();
  }

  Future<String?> uploadFile(String name, String image) async {
    final response = await _authRepository.uploadFile(name: name, image: image);
    if (response.status == StatusResponse.success) {
      return response.result ?? '';
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kPrimaryColor,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText: Text(response.message ?? 'Gagal upload image',
            style: text12WhiteRegular),
      ));
      return null;
    }
  }

  Future<void> editProfile() async {
    actionStatus = ActionStatus.loading;
    update();
    var body = ProfileBody(
      name: namaController.text,
      gender: nameGender,
      phone: phoneController.text,
      email: emailController.text,
      birthDate: selectedDatePicker,
      image: imageUrl,
    );
    final response = await _authRepository.editUserProfile(
        id: userData?.id ?? 0, body: body);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      AppPreference().updateUserData(
          UserModel(user: User.fromJson(response.result!.toJson())));
      update();
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kBlack,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText:
            Text('Profil berhasil diperbarui', style: text12WhiteRegular),
      ));
    } else {
      actionStatus = ActionStatus.failed;
      update();
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kPrimaryColor,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText: Text(response.message ?? '', style: text12WhiteRegular),
      ));
    }
  }

  Future<void> updateUser() async {
    final controller = Get.find<AccountController>();
    controller.setDataUser(true);
  }

  @override
  void onInit() {
    userData = Get.arguments;
    setValueForm();
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    super.onInit();
  }
}
