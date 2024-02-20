import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetmarket/components/bottom_sheet/show_bottom_sheet.dart';
import 'package:jetmarket/domain/core/interfaces/file_repository.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/koperasi_pages/ajukan_pinjaman/widget/item_tenor.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';

import '../../../../domain/core/interfaces/loan_repository.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/status_response.dart';

class AjukanPinjamanController extends GetxController {
  final LoanRepository _loanRepository;
  final FileRepository _fileRepository;

  AjukanPinjamanController(this._loanRepository, this._fileRepository);
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ktpController = TextEditingController();
  TextEditingController noRekController = TextEditingController();
  TextEditingController nameRekController = TextEditingController();
  TextEditingController nominalRekController = TextEditingController();

  var actionStatus = ActionStatus.initalize;
  bool isName = false;
  bool isAddress = false;
  bool isKtp = false;
  bool isNoRek = false;
  bool isNameRek = false;
  bool isNominalPinjaman = false;
  int nominal = 0;

  String? selectedRekening;
  String? imageUrl;

  List<String> listRekening = [
    "BCA",
    "BNI",
    "BRI",
    "Mandiri",
    "CIMB",
  ];
  List<int> tenor = [1, 3, 6, 12];
  int selectedTenor = 1;
  String? imagesUser;
  File? userFile;
  Future getImageMenu() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.camera, imageQuality: 30);

    imagesUser = imagePicked1!.path;
    userFile = File(imagePicked1.path);
    imageUrl = null;

    update();
    final urlImage = await uploadFile('user-loan', userFile?.path ?? '');
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
    }
  }

  Future getImageGalery() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.gallery, imageQuality: 30);

    imagesUser = imagePicked1!.path;
    userFile = File(imagePicked1.path);
    imageUrl = null;
    update();
    final urlImage = await uploadFile('user-loan', imagePicked1.path);
    if (urlImage != null) {
      imageUrl = urlImage;
      update();
    }
  }

  Future<String?> uploadFile(String name, String image) async {
    final response = await _fileRepository.uploadFile(name: name, image: image);
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

  void selectRekening(String value) {
    selectedRekening = value;
    update();
  }

  void listenNameForm(String value) {
    if (value.isNotEmpty) {
      isName = true;
      update();
    } else {
      isName = false;
      update();
    }
  }

  void listenAddressForm(String value) {
    if (value.isNotEmpty) {
      isAddress = true;
      update();
    } else {
      isAddress = false;
      update();
    }
  }

  void listenKtpForm(String value) {
    if (value.length >= 16) {
      isKtp = true;
      update();
    } else {
      isKtp = false;
      update();
    }
  }

  void listenNoRekForm(String value) {
    if (value.isNotEmpty) {
      isNoRek = true;
      update();
    } else {
      isNoRek = false;
      update();
    }
  }

  void listenNameRekForm(String value) {
    if (value.isNotEmpty) {
      isNameRek = true;
      update();
    } else {
      isNameRek = false;
      update();
    }
  }

  void listenNominalRekForm(String value) {
    if (value.isNotEmpty) {
      nominal = int.parse(value.removeComma);
      log("Nominal : $nominal");
      isNominalPinjaman = true;
      update();
    } else {
      nominal = 0;
      isNominalPinjaman = false;
      update();
    }
  }

  Future<void> submitPinjaman() async {
    actionStatus = ActionStatus.loading;
    update();
    var param = LoanProposeParam(
        name: nameController.text,
        address: addressController.text,
        ktpNumber: ktpController.text,
        ktpImage: imageUrl,
        bank: selectedRekening,
        rekening: noRekController.text,
        nameHolder: nameRekController.text,
        amount: int.parse(nominalRekController.text.removeComma),
        tenor: selectedTenor);
    final response = await _loanRepository.loanPropose(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      update();
      Get.offNamed(Routes.PENGAJUAN_PROSES_PINJAMAN,
          arguments: response.result);
    } else {
      actionStatus = ActionStatus.failed;
      update();
    }
  }

  void selectTenor(int value) {
    selectedTenor = value;
    update();
    Get.back();
  }

  String get getTenor {
    return "$selectedTenor Bulan (${(nominal / selectedTenor).toStringAsFixed(0).toIdrFormat} / Bulan)";
  }

  void openSelectedTenor() {
    CustomBottomSheet.show(child: const ItemTenor());
  }
}
