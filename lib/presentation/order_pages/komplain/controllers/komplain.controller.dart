import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import '../../../../components/dialog/app_dialog_confirmation.dart';
import '../../../../domain/core/interfaces/file_repository.dart';
import '../../../../domain/core/interfaces/order_repository.dart';
import '../../../../domain/core/model/model_data/submit_refund_model.dart';
import '../../../../domain/core/model/params/order/refund_param.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class KomplainController extends GetxController {
  final OrderRepository _orderRepository;
  final FileRepository _fileRepository;
  KomplainController(this._orderRepository, this._fileRepository);

  TextEditingController reasonController = TextEditingController();
  var descriptionController = <TextEditingController>[];
  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = (ActionStatus.initalize).obs;

  SubmitRefundModel? submitRefundModel;
  File? imageFile;
  int? seledtedSolutionIndex;

  List<Products> addProduct = [];
  var dataProof = <Proofs>[];
  var proofImagesView = <File>[];
  var proofImages = <String>[];
  var proofImagesPath = <File>[];

  bool selectAll = false;
  int totalPrice = 0;
  int countLenght = 0;

  Future<void> getRefund() async {
    screenStatus(ScreenStatus.loading);
    final response = await _orderRepository.getRefund(Get.arguments);
    if (response.status == StatusResponse.success) {
      submitRefundModel = response.result;
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void selectSolution(int index) {
    seledtedSolutionIndex = index;
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
      addProduct.assignAll(submitRefundModel?.products ?? []);
      totalPrice = addProduct.fold(0, (subtotal, element) {
        return subtotal + (element.price! * element.quantity!);
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
        totalPrice += (item.price! * item.quantity!);
      }
      update();
    } else {
      addProduct.add(data);
      update();

      totalPrice = 0;
      for (var item in addProduct) {
        totalPrice += (item.price! * item.quantity!);
      }
      update();
    }
  }

  Future getImageCamera() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.camera, imageQuality: 30);
    imageFile = File(imagePicked1?.path ?? '');
    update();
    final urlImage = await uploadFile(
        "proofs-${proofImages.length + 1}", imageFile?.path ?? '');
    if (urlImage != null) {
      proofImages.add(urlImage);
      updateDataProof(urlImage);
      update();
    }
  }

  Future getImageGalery() async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.gallery, imageQuality: 30);
    imageFile = File(imagePicked1?.path ?? '');
    update();
    final urlImage = await uploadFile(
        "proofs-${proofImages.length + 1}", imageFile?.path ?? '');
    if (urlImage != null) {
      proofImages.add(urlImage);
      updateDataProof(urlImage);
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

  // Future pickImagePfoof() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //     final filePath = result.files.single.path ?? '';
  //     if (filePath.toLowerCase().endsWith('.mp4') ||
  //         filePath.toLowerCase().endsWith('.mov')) {
  //       final thumbnailPath = await VideoThumbnail.thumbnailFile(
  //         video: filePath,
  //         imageFormat: ImageFormat.PNG,
  //         maxHeight: 200,
  //         quality: 100,
  //       );
  //       proofImagesView.add(File(thumbnailPath ?? ''));
  //       proofImagesPath.add(File(filePath));
  //     } else {
  //       proofImagesView.add(File(filePath));
  //       proofImagesPath.add(File(filePath));
  //     }
  //     updateDataProof();
  //   } else {}
  // }

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

  void updateDataProof(String image) {
    List<String> textValues = [];
    for (var controller in descriptionController) {
      textValues.add(controller.text);
    }
    descriptionController.add(TextEditingController());
    for (int i = 0; i < descriptionController.length - 1; i++) {
      descriptionController[i].text = textValues[i];
    }
    dataProof.add(Proofs(
      image: image,
      description: "",
    ));
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

  Future<void> submitComplain() async {
    Get.back();
    actionButton(ActionStatus.loading);
    List<Proofs> newDataProofs = [];
    newDataProofs.clear();
    for (int i = 0; i < dataProof.length; i++) {
      newDataProofs.add(Proofs(
        image: dataProof[i].image,
        description: descriptionController[i].text,
      ));
    }
    var param = RefundParam(
        id: Get.arguments,
        body: BodyRefundParam(
            itemIds: List.generate(
                addProduct.length, (index) => addProduct[index].variantId ?? 0),
            reason: reasonController.text,
            proofs: newDataProofs,
            requestReturn: seledtedSolutionIndex == 0));
    final response = await _orderRepository.submitRefund(param);
    if (response.status == StatusResponse.success) {
      actionButton(ActionStatus.success);
      Get.offNamedUntil(Routes.DETAIL_RETURN,
          (route) => route.settings.name == Routes.MAIN_PAGES,
          arguments: response.result);
    } else {
      actionButton(ActionStatus.failed);
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  @override
  void onInit() {
    getRefund();

    super.onInit();
  }
}
