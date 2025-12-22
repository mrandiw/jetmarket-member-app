import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/cart_repository.dart';
import 'package:jetmarket/domain/core/interfaces/chat_repository.dart';
import 'package:jetmarket/domain/core/interfaces/product_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/category_product.dart';
import 'package:jetmarket/domain/core/model/model_data/product.dart';
import 'package:jetmarket/domain/core/model/params/cart/cart_product_param.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/assets/assets_images.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:logger/logger.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../components/dialog/dialog_noconnection.dart';
import '../../../../domain/core/model/model_data/banner.dart';
import '../../../../domain/core/model/params/product/product_param.dart';
import '../../../../domain/core/model/params/product/product_seller_param.dart';
import '../../../../utils/network/screen_status.dart';
import '../widget/filter_product.dart';

enum SeeAllProductType { popular, promo }

class HomeController extends GetxController {
  final ProductRepository _productRepository;
  final CartRepository _cartRepository;
  final ChatRepository _chatRepository;
  HomeController(
      this._productRepository, this._cartRepository, this._chatRepository);
  TextEditingController searchController = TextEditingController();
  var screenStatus = (ScreenStatus.success).obs;
  var isHomeScreen = true.obs;
  static const _pageSize = 10;
  static const _pagePopularSize = 10;
  static const _pagePromoSize = 10;

  late PagingController<int, Product> pagingController;
  late PagingController<int, Product> pagingPopularController;
  late PagingController<int, Product> pagingPromoController;
  final RefreshController homeRefreshController =
      RefreshController(initialRefresh: false);
  final RefreshController seeAllRefreshController =
      RefreshController(initialRefresh: false);

  RefreshController get activeRefreshController =>
      isHomeScreen.value ? homeRefreshController : seeAllRefreshController;

  List<CategoryProduct> categoryProduct = [];
  List<Banners> banners = [];
  List<Product> popularProducts = [];
  List<Product> promoProducts = [];
  bool isLoadingPromo = false;

  String? searchProduct;
  bool searchActived = false;

  String? selectedSortProduct;
  CategoryProduct? selectedCategoryProduct;
  String? selectedStars;
  bool isFiltered = false;

  int unreadChat = 0;
  SeeAllProductType seeAllProductType = SeeAllProductType.popular;

  List<String> sortProduct = [
    'Terbaru',
    'Harga Tertinggi',
    'Harga Terendah',
    'Pembelian Terbanyak'
  ];

  List<String> categoryProductFilter = [
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

  setBanner({required List<Banners> data}) {
    banners.assignAll(data);
    update();
  }

  setCategory({required List<CategoryProduct> data}) {
    CategoryProduct staticData = CategoryProduct(
        id: 0,
        name: 'Semua',
        image:
            'https://pztgbokzuoyfdfupkjon.supabase.co/storage/v1/object/public/static/kategori_semua.png');
    data.insert(0, staticData);
    categoryProduct.assignAll(data);
    update();
  }

  setPopular({required List<Product> data}) {
    popularProducts.assignAll(data);
    update();
  }

  setPromo({required List<Product> data}) {
    promoProducts.assignAll(data);
    update();
  }

  Future<void> getBanner() async {
    final response = await _productRepository.getBanner();
    if (response.status == StatusResponse.success) {
      setBanner(data: response.result ?? []);
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          refreshData();
        });
      }
    }
  }

  Future<void> getCategoryProduct() async {
    final response = await _productRepository.getCategoryProduct();
    if (response.status == StatusResponse.success) {
      setCategory(data: response.result ?? []);
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          refreshData();
        });
      }
    }
  }

  Future<void> getPopularProduct() async {
    var param = const ProductSellerParam(
        page: 1, size: 10, sellerId: 1, sortBy: 'popular');
    final response = await _productRepository.getProductBySeller(param);
    if (response.status == StatusResponse.success) {
      setPopular(data: response.result ?? []);
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          refreshData();
        });
      }
    }
  }

  Future<void> getPromoProduct() async {
    try {
      isLoadingPromo = true;
      update();
      var param =
          const ProductParam(page: 1, size: _pagePromoSize, sortBy: 'highest');
      final response = await _productRepository.getProductPromo(param);

      if (response.status == StatusResponse.success) {
        setPromo(data: response.result ?? []);
      } else if (response.status == StatusResponse.noInternet) {
        if (!(Get.isDialogOpen ?? false)) {
          DialogNoConnection.show(onReload: () {
            Get.back();
            refreshData();
          });
        }
      }
    } catch (e) {
      Logger().w(e);
    } finally {
      isLoadingPromo = false;
      update();
    }
  }

  Future<void> getProduct(int pageKey) async {
    try {
      var param = ProductParam(
          page: pageKey,
          size: _pageSize,
          name: searchProduct,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
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

  Future<void> getProductPopularOnPage(int pageKey) async {
    try {
      var param = ProductSellerParam(
          page: pageKey,
          size: _pagePopularSize,
          sellerId: 1,
          name: searchProduct,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProductBySeller(param);
      final isLastPage = response.result!.length < _pagePopularSize;

      if (isLastPage) {
        pagingPopularController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingPopularController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingPopularController.error = error;
    }
  }

  Future<void> getProductPromoOnPage(int pageKey) async {
    try {
      var param = ProductParam(
          page: pageKey,
          size: _pagePromoSize,
          name: searchProduct,
          minRating: double.parse(selectedStars ?? '0'),
          sortBy: convertToEnglish(selectedSortProduct),
          categoryId: selectedCategoryProduct?.id);
      final response = await _productRepository.getProductPromo(param);
      final isLastPage = response.result!.length < _pagePromoSize;

      if (isLastPage) {
        pagingPromoController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingPromoController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingPromoController.error = error;
    }
  }

  Future<void> refreshData() async {
    await Future.delayed(2.seconds, () {
      selectedSortProduct = null;
      selectedCategoryProduct = null;
      selectedStars = null;
      searchProduct = null;
      searchController.clear();
      searchActived = false;
      categoryProduct.clear();
      banners.clear();
      popularProducts.clear();
      promoProducts.clear();
      update();
      getBanner();
      getCategoryProduct();
      getPopularProduct();
      getPromoProduct();
    });
  }

  void _resetFilterAndSearch() {
    selectedSortProduct = null;
    selectedCategoryProduct = null;
    selectedStars = null;
    searchProduct = null;
    searchController.clear();
    searchActived = false;
  }

  void _refreshSeeAllPaging() {
    if (seeAllProductType == SeeAllProductType.popular) {
      pagingPopularController.refresh();
    } else {
      pagingPromoController.refresh();
    }
  }

  void seeAllProduct(SeeAllProductType type) {
    _resetFilterAndSearch();
    seeAllProductType = type;
    update();
    isHomeScreen.value = false;
    _refreshSeeAllPaging();
  }

  void backToHomeFromSeeAll() {
    _resetFilterAndSearch();
    update();
    isHomeScreen.value = true;
    pagingController.refresh();
    refreshData();
  }

  void openFilter() {
    CustomBottomSheet.show(child: const FilterProduct());
  }

  void searchProducts(String value) {
    searchActived = value.isNotEmpty;
    update();
    searchProduct = value;
    if (isHomeScreen.value) {
      pagingController.refresh();
    } else {
      _refreshSeeAllPaging();
    }
  }

  void filterProduct() {}

  void selectSortProduct(bool select, String value) {
    if (value == selectedSortProduct) {
      selectedSortProduct = null;
    } else {
      selectedSortProduct = value;
    }
    update();
  }

  String? convertToEnglish(String? value) {
    switch (value) {
      case 'Terbaru':
        return 'newest';
      case 'Harga Tertinggi':
        return 'highest';
      case 'Harga Terendah':
        return 'lowest';
      case 'Pembelian Terbanyak':
        return 'popular';
      default:
        return null;
    }
  }

  void selectCategoryProduct(bool select, CategoryProduct value) {
    if (value == selectedCategoryProduct) {
      selectedCategoryProduct = null;
    } else {
      selectedCategoryProduct = value;
    }
    update();
  }

  void selectStarts(bool select, String value) {
    if (value == selectedStars) {
      selectedStars = null;
    } else {
      selectedStars = value;
    }
    update();
  }

  void toCategoryProduct(int id, int index) {
    if (index == 0) {
      Get.toNamed(Routes.ALL_CATEGORY);
    } else {
      Get.toNamed(Routes.PRODUCT_BYCATEGORY, arguments: ['home', 0, id]);
    }
  }

  void toDetailProduct(int id) {
    Get.toNamed(Routes.DETAIL_PRODUCT, arguments: [id, null]);
  }

  void applyFilterProduct() {
    isFiltered = true;
    update();
    Get.back();
    if (isHomeScreen.value) {
      // getProduct(1);
      pagingController.refresh();
    } else {
      // getProductPopularOnPage(1);
      _refreshSeeAllPaging();
    }
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      pagingController.itemList?.clear();
      // getSavingHistory(1);
      if (isHomeScreen.value) {
        pagingController.refresh();
        getPopularProduct();
      } else {
        _refreshSeeAllPaging();
      }
      getCategoryProduct();
      getPromoProduct();
      getCountChart();
    });
    activeRefreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) activeRefreshController.loadComplete();
  }

  void onTapBanner(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<int> getCountChart() async {
    final customer = AppPreference().getUserData();
    try {
      var param = CartProductParam(
          customerId: customer?.user?.id ?? 0, page: 1, size: 1000);
      final response = await _cartRepository.getCartProduct(param);

      final totalProducts = response.result
          ?.map((e) => e.products!.length)
          .fold(0, (sum, length) => sum + length);

      return totalProducts ?? 0;
    } finally {}
  }

  Future<int> getUnreadChat() async {
    final response = await _chatRepository.getUnreadChat();

    return response.result ?? 0;
  }

  @override
  void onInit() {
    getBanner();
    getCategoryProduct();
    getPopularProduct();
    getPromoProduct();
    getCountChart();
    pagingController = PagingController(firstPageKey: 1);
    pagingPopularController = PagingController(firstPageKey: 1);
    pagingPromoController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getProduct(page);
    });

    pagingPopularController.addPageRequestListener((page) {
      getProductPopularOnPage(page);
    });

    pagingPromoController.addPageRequestListener((page) {
      getProductPromoOnPage(page);
    });

    super.onInit();
  }

  @override
  void onClose() {
    homeRefreshController.dispose();
    seeAllRefreshController.dispose();
    super.onClose();
  }
}
