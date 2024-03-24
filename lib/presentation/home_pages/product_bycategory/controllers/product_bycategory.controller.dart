import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../components/dialog/dialog_noconnection.dart';
import '../../../../domain/core/interfaces/product_repository.dart';
import '../../../../domain/core/model/model_data/category_product.dart';
import '../../../../domain/core/model/model_data/product.dart';
import '../../../../domain/core/model/params/product/product_param.dart';
import '../../../../domain/core/model/params/product/product_seller_param.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/screen_status.dart';
import '../../../../utils/network/status_response.dart';

class ProductBycategoryController extends GetxController {
  final ProductRepository _productRepository;
  ProductBycategoryController(this._productRepository);
  var screenStatus = (ScreenStatus.success).obs;
  final int _pageSize = 10;
  int? categoryId;
  int? sellerId;

  PagingController<int, Product> pagingController =
      PagingController(firstPageKey: 1);
  List<CategoryProduct> categoryProduct = [];

  CategoryProduct? selectedCategoryProduct;

  setCategory({required List<CategoryProduct> data}) {
    categoryProduct.assignAll(data);
    final selectedId = Get.arguments[2];

    selectedCategoryProduct = data.firstWhereOrNull((e) => e.id == selectedId);

    update();
  }

  Future<void> getCategoryProductBySeller(int sellerId) async {
    screenStatus(ScreenStatus.loading);

    final response =
        await _productRepository.getCategoryProductBySeller(sellerId);
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
      screenStatus(ScreenStatus.success);
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          getCategoryProductBySeller(sellerId);
        });
      }
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  Future<void> getCategoryProduct() async {
    screenStatus(ScreenStatus.loading);

    final response = await _productRepository.getCategoryProduct();
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
      screenStatus(ScreenStatus.success);
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          getCategoryProduct();
        });
      }
    } else {
      screenStatus(ScreenStatus.failed);
    }
  }

  Future<void> getProductBySeller(int pageKey, int sellerId) async {
    try {
      var param = ProductSellerParam(
          page: pageKey,
          size: _pageSize,
          // sellerId: sellerId,
          sellerId: 1,
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProductBySeller(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> getProduct(int pageKey) async {
    try {
      var param = ProductParam(
          page: pageKey,
          size: _pageSize,
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProduct(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void selectCategoryProduct(bool select, CategoryProduct value) {
    selectedCategoryProduct = value;
    update();
  }

  void toDetailProduct(int id) {
    Get.toNamed(Routes.DETAIL_PRODUCT, arguments: [id, null]);
  }

  void selectCategory(CategoryProduct? value) {
    selectedCategoryProduct = value;
    update();
    selectCategoryByCondition();
    pagingController.refresh();
  }

  selectCategoryByCondition() {
    if (Get.arguments[0] == 'store') {
      getProductBySeller(1, Get.arguments[1]);
    }
  }

  checkArgument() {
    if (Get.arguments[0] == 'store') {
      getCategoryProductBySeller(Get.arguments[1]);
      pagingController.addPageRequestListener((page) {
        getProductBySeller(page, Get.arguments[1]);
      });
    } else {
      getCategoryProduct();
      pagingController.addPageRequestListener((page) {
        getProduct(page);
      });
    }
  }

  @override
  void onInit() {
    checkArgument();
    super.onInit();
  }
}
