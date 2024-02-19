import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jetmarket/components/snackbar/app_snackbar_black.dart';
import 'package:jetmarket/domain/core/interfaces/file_repository.dart';
import 'package:jetmarket/domain/core/interfaces/review_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/product_review_model.dart';
import 'package:jetmarket/domain/core/model/params/review/review_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/account_pages/review_product/controllers/review_product.controller.dart';
import 'package:jetmarket/presentation/order_pages/detail_order/controllers/detail_order.controller.dart';
import 'package:jetmarket/presentation/order_pages/order/controllers/order.controller.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/network/action_status.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class ReviewOrderController extends GetxController {
  final FileRepository _fileRepository;
  final ReviewRepository _reviewRepository;
  ReviewOrderController(this._fileRepository, this._reviewRepository);
  List<TextEditingController> reviewController = [];
  List<ProductReviewModel> productReview = [];
  File? imageFile;

  var screenStatus = (ScreenStatus.initalize).obs;
  var actionButton = (ActionStatus.initalize).obs;

  List<int> selectedRating = [];
  List<List<String>> imagesReview = [];
  List<int> reviewTextLenght = [];

  Future<void> getProductReview() async {
    screenStatus(ScreenStatus.loading);
    final response = await _reviewRepository.getReview(Get.arguments[0]);
    if (response.status == StatusResponse.success) {
      productReview = response.result ?? [];
      setGenerateData(response.result?.length ?? 0);
      update();
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  setGenerateData(int lenght) {
    reviewController =
        List.generate(lenght, (index) => TextEditingController());
    selectedRating = List.generate(lenght, (index) => 0);
    imagesReview = List.generate(lenght, (index) => <String>[]);
    reviewTextLenght = List.generate(lenght, (index) => 0);
    update();
  }

  void listenReviewText(String value, int index) {
    reviewTextLenght[index] = value.length;
    update();
  }

  void changeRating(int value, int index) {
    selectedRating[index] = value;
    update();
  }

  Future getImageCamera(String name, int index) async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.camera, imageQuality: 30);
    imageFile = File(imagePicked1?.path ?? '');
    update();
    final urlImage = await uploadFile(name, imageFile?.path ?? '');
    if (urlImage != null) {
      imagesReview[index].add(urlImage);
      update();
    }
  }

  Future getImageGalery(String name, int index) async {
    Get.back();
    final ImagePicker picker1 = ImagePicker();
    final imagePicked1 =
        await picker1.pickImage(source: ImageSource.gallery, imageQuality: 30);
    imageFile = File(imagePicked1?.path ?? '');
    update();
    final urlImage = await uploadFile(name, imageFile?.path ?? '');
    if (urlImage != null) {
      imagesReview[index].add(urlImage);
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

  void deleteImageReview(int indexProduct, int index) {
    imagesReview[indexProduct].removeAt(index);
    update();
  }

  Future<void> sendReview() async {
    actionButton(ActionStatus.loading);
    var param = ReviewParam(
        id: Get.arguments[0],
        body: List.generate(
            reviewController.length,
            (index) => BodyDataReview(
                  orderItemId: Get.arguments[0],
                  productId: productReview[index].productId,
                  rating: selectedRating[index],
                  review: reviewController[index].text,
                  image: imagesReview[index],
                )));

    final response = await _reviewRepository.sendReview(param);
    if (response.status == StatusResponse.success) {
      actionButton(ActionStatus.success);
      if (Get.arguments[1] != null) {
        if (Get.arguments[1] == 'review') {
          Get.offNamed(Routes.DETAIL_ORDER,
              arguments: [Get.arguments[0], "review", null, null]);
        } else if (Get.arguments[1] == 'review-detail' ||
            Get.arguments[1] == 'receive-review') {
          Get.back();
          refreshDetailOrder();
        } else if (Get.arguments[1] == 'review-product') {
          Get.back();
          refreshReview();
          AppSnackbarBlack.show('Produk berhasil direview');
        }
      }
    } else {
      actionButton(ActionStatus.failed);
    }
  }

  void refreshOrder() {
    final controller = Get.find<OrderController>();
    controller.pagingController.refresh();
  }

  void refreshReview() {
    final controller = Get.find<ReviewProductController>();
    controller.pagingController.refresh();
  }

  void refreshDetailOrder() {
    final controller = Get.find<DetailOrderController>();
    controller.getDetailOrder();
    controller.argumentBack = 'review';
  }

  void backToOrder() {
    if (Get.arguments[1] == 'receive-review') {
      Get.back();
      Get.back();
      refreshOrder();
    } else {
      Get.back();
    }
  }

  @override
  void onInit() {
    getProductReview();
    super.onInit();
  }
}
