import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../domain/core/model/model_data/detail_product.dart';
import '../../../../domain/core/model/model_data/product_review_customer.dart';
import '../../../../utils/network/screen_status.dart';

class DetailProductController extends GetxController {
  final ProductRepository _productRepository;
  DetailProductController(this._productRepository);
  var screenStatus = (ScreenStatus.success).obs;
  PageController pageController = PageController();
  int currentIndexImage = 0;
  bool readMore = false;
  int? lenghtDescription;
  Variants? selectedVariant;

  DetailProduct? detailProduct;
  List<ProductReviewCustomer> productReviewCustomer = [];

  setData(
      {required DetailProduct detail,
      required List<ProductReviewCustomer> review}) {
    detailProduct = detail;
    productReviewCustomer.assignAll(review);
    lenghtDescription = detail.description?.length;
    update();
  }

  Future<void> getData(int id) async {
    screenStatus(ScreenStatus.loading);
    final responses = await Future.wait([
      _productRepository.getProductById(id),
      _productRepository.getProductReview(id),
    ]);
    if (responses
        .every((response) => response.status == StatusResponse.success)) {
      setData(
        detail: responses[0].result as DetailProduct,
        review: responses[1].result as List<ProductReviewCustomer>,
      );
      selectedVariant = detailProduct?.variants?.first;
      screenStatus(ScreenStatus.success);
    } else if (responses
        .any((response) => response.status == StatusResponse.timeout)) {
      screenStatus(ScreenStatus.timeout);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void onImageSlide(int index) {
    currentIndexImage = index;
    update();
  }

  void selectVariant(Variants? value) {
    selectedVariant = value;
    update();
  }

  void onReadMore() {
    readMore = !readMore;
    update();
  }

  void previewImage(ImageProvider<Object> imageProvider) {
    showImageViewer(Get.context!, imageProvider,
        swipeDismissible: true, doubleTapZoomable: true);
  }

  void toDetailStore(int sellerId) {
    Get.offAndToNamed(Routes.DETAIL_STORE,
        arguments: {'seller_id': sellerId, 'product_id': detailProduct?.id});
  }

  @override
  void onInit() {
    getData(Get.arguments);

    super.onInit();
  }
}
