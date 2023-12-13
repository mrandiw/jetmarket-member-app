import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

class DetailProductController extends GetxController {
  PageController pageController = PageController();
  int currentIndexImage = 0;
  bool readMore = false;

  void onImageSlide(int index) {
    currentIndexImage = index;
    update();
  }

  void onReadMore() {
    readMore = !readMore;
    update();
  }

  void toDetailStore() {
    Get.toNamed(Routes.DETAIL_STORE);
  }
}
