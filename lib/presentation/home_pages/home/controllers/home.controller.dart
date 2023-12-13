import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../widget/filter_product.dart';

class HomeController extends GetxController {
  TextEditingController searchController = TextEditingController();

  String selectedSortProduct = "";
  String selectedCategoryProduct = "";
  String selectedStars = "";

  List<String> sortProduct = [
    'Terbaru',
    'Harga Tertinggi',
    'Harga Terendah',
    'Ulasan Terbanyak',
    'Pembelian Terbanyak'
  ];

  List<String> categoryProduct = [
    'Perlengkapan Sekolah',
    'Elektronik',
    'Kecantikan'
  ];

  List<String> stars = ["4"];

  List<dynamic> listCategory = [
    {"name": "Lihat Semua", "image": allProduct},
    {"name": "Bahan Pokok", "image": bahanPokok},
    {"name": "Minuman", "image": snack},
    {"name": "Snack", "image": snack},
    {"name": "Atk", "image": atk},
    {"name": "Perawatan", "image": perawatan},
    {"name": "Bayi", "image": bayi}
  ];

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {
      selectedSortProduct = "";
      selectedCategoryProduct = "";
      selectedStars = "";
      update();
    });
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterProduct());
  }

  void searchProduct() {}

  void filterProduct() {}

  void selectSortProduct(bool select, String value) {
    if (value == selectedSortProduct) {
      selectedSortProduct = "";
    } else {
      selectedSortProduct = value;
    }
    update();
  }

  void selectCategoryProduct(bool select, String value) {
    if (value == selectedCategoryProduct) {
      selectedCategoryProduct = "";
    } else {
      selectedCategoryProduct = value;
    }
    update();
  }

  void selectStarts(bool select, String value) {
    if (value == selectedStars) {
      selectedStars = "";
    } else {
      selectedStars = value;
    }
    update();
  }

  void toDetailProduct() {
    Get.toNamed(Routes.DETAIL_PRODUCT);
  }

  void applyFilterProduct() {
    Get.back();
  }
}
