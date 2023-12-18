import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/domain/core/interfaces/product_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class AllCategoryController extends GetxController {
  final ProductRepository _productRepository;
  AllCategoryController(this._productRepository);
  TextEditingController searchController = TextEditingController();
  var screenStatus = (ScreenStatus.initalize).obs;

  List<CategoryProduct> categoryProduct = [];
  List<CategoryProduct> searchCategoryProduct = [];

  setCategory({required List<CategoryProduct> data}) {
    List<CategoryProduct> filteredData = List.from(data);
    filteredData.removeWhere((category) => category.name == 'Semua');
    categoryProduct.assignAll(filteredData);
    searchCategoryProduct.assignAll(filteredData);
    update();
  }

  Future<void> getCategoryProduct() async {
    screenStatus(ScreenStatus.loading);
    final response = await _productRepository.getCategoryProduct();
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
      screenStatus(ScreenStatus.success);
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  void searchCategory(String value) {
    categoryProduct = searchCategoryProduct
        .where((category) =>
            category.name!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  void toCategoryProduct(int id) {
    Get.toNamed(Routes.PRODUCT_BYCATEGORY, arguments: ['category', 0, id]);
  }

  @override
  void onInit() {
    getCategoryProduct();
    super.onInit();
  }
}
