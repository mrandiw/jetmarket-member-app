import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../components/button/app_button.dart';
import '../../../components/dialog/app_dialog_confirmation.dart';

class KomplainController extends GetxController {
  TextEditingController reasonController = TextEditingController();
  var descriptionController = <TextEditingController>[].obs;

  String selectedReason = "Kurang/tidak lengkap";
  List<dynamic> products = [];
  List<String> reasonReturn = [
    'Barang rusak karena penjual atau kurir',
    'Tidak sesuai deskripsi, salah warna/ukuran',
    'Kurang/tidak lengkap'
  ];

  List<dynamic> addProduct = [];
  var dataProof = <Map<String, dynamic>>[].obs;
  var proofImagesView = <File>[].obs;
  var proofImagesPath = <File>[].obs;

  bool selectAll = false;
  int totalPrice = 0;
  int countLenght = 0;

  void changeReasonReturn(String value) {
    selectedReason = value;
    update();
  }

  void selectAllProduct(bool value) {
    selectAll = value;
    totalPrice = 0;
    if (value == false) {
      addProduct.clear();
      update();
    } else {
      addProduct.clear();
      addProduct.assignAll(products);
      totalPrice = addProduct.fold(0, (subtotal, element) {
        return subtotal + (int.parse(element['price'] ?? '0'));
      });
      update();
    }
  }

  void selectProduct(bool value, dynamic data) {
    selectAll = false;
    if (addProduct.contains(data)) {
      addProduct.remove(data);
      update();
      totalPrice = 0;
      for (var item in addProduct) {
        totalPrice += (int.parse(item['price']));
      }
      update();
    } else {
      addProduct.add(data);
      update();

      totalPrice = 0;
      for (var item in addProduct) {
        totalPrice += (int.parse(item['price']));
      }
      update();
    }
  }

  Future pickImagePfoof() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final filePath = result.files.single.path ?? '';
      if (filePath.toLowerCase().endsWith('.mp4') ||
          filePath.toLowerCase().endsWith('.mov')) {
        final thumbnailPath = await VideoThumbnail.thumbnailFile(
          video: filePath,
          imageFormat: ImageFormat.PNG,
          maxHeight: 200,
          quality: 100,
        );
        proofImagesView.add(File(thumbnailPath ?? ''));
        proofImagesPath.add(File(filePath));
      } else {
        proofImagesView.add(File(filePath));
        proofImagesPath.add(File(filePath));
      }
      updateDataProof();
    } else {}
  }

//   Future<void> clearAppStorage() async {
//   Directory appDir = await getApplicationDocumentsDirectory();
//   if (appDir.existsSync()) {
//     List<FileSystemEntity> files = appDir.listSync(recursive: true);
//     for (FileSystemEntity file in files) {
//       if (file is File) {
//         await file.delete();
//       }
//     }
//   }
// }

  void updateDataProof() {
    List<String> textValues = [];
    for (var controller in descriptionController) {
      textValues.add(controller.text);
    }
    descriptionController.add(TextEditingController());
    for (int i = 0; i < descriptionController.length - 1; i++) {
      descriptionController[i].text = textValues[i];
    }
    dataProof.add({'name': 'Pensil Warna 2in1 12 Pcs ${dataProof.length}'});
  }

  void deleteProof(int index) {
    AppSnackbar.show(type: SnackType.dark, message: 'Bukti foto/video dihapus');
    dataProof.removeAt(index);
    descriptionController.removeAt(index);
    update();
  }

  void sendComplain() {
    AppDialogConfirmation.show(
        title: 'Ajukan Komplain',
        message: 'Yakin ingin mengajukan pengembalian barang/dana?',
        onTesText: 'Ajukan',
        onPressed: () => submitComplain());
  }

  void submitComplain() {
    Get.offNamedUntil(Routes.DETAIL_RETURN,
        (route) => route.settings.name == Routes.MAIN_PAGES);
  }

  @override
  void onInit() {
    products = List.generate(
        2,
        (index) =>
            {'name': 'Pensil Warna 2in1 12 Pcs $index', 'price': '45300'});
    super.onInit();
  }
}
