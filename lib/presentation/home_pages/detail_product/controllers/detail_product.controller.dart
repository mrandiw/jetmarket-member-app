import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/model/params/cart/cart_body.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/network/action_status.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../domain/core/interfaces/cart_repository.dart';
import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../domain/core/model/model_data/detail_product.dart';
import '../../../../domain/core/model/model_data/product_review_customer.dart';
import '../../../../utils/network/screen_status.dart';

class DetailProductController extends GetxController {
  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  DetailProductController(this._productRepository, this._cartRepository);
  var screenStatus = (ScreenStatus.success).obs;
  var actionAddToCart = (ActionStatus.initalize).obs;
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

  Future<void> addToCart() async {
    actionAddToCart(ActionStatus.loading);
    final customer = AppPreference().getUserData();
    var body = CartBody(
      sellerId: detailProduct?.seller?.id ?? 0,
      customerId: customer?.user?.id ?? 0,
      productId: detailProduct?.id ?? 0,
      variantId: selectedVariant?.id ?? 0,
    );
    final response = await _cartRepository.addToCart(body);
    if (response.status == StatusResponse.success) {
      actionAddToCart(ActionStatus.success);
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kBlack,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText: Text('Berhasil ditambahkan ke keranjang',
            style: text12WhiteRegular),
      ));
    } else {
      actionAddToCart(ActionStatus.failed);
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
        backgroundColor: kBlack,
        duration: 2.seconds,
        borderRadius: 8.r,
        messageText:
            Text('Gagal menambahkan ke keranjang', style: text12WhiteRegular),
      ));
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

  void toCartProduct() {
    Get.toNamed(Routes.CART);
  }

  @override
  void onInit() {
    getData(Get.arguments);

    super.onInit();
  }
}
