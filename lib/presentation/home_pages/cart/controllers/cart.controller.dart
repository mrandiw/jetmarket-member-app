import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/cart_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/cart_product.dart';
import 'package:jetmarket/domain/core/model/params/cart/cart_product_param.dart';
import 'package:jetmarket/domain/core/model/params/cart/update_qty_param.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../domain/core/model/params/cart/update_note_param.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/status_response.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository;
  CartController(this._cartRepository);
  static const _pageSize = 10;
  late PagingController<int, CartProduct> pagingController;
  List<int> selectedId = [];
  List<CartProduct> selectedProduct = [];
  List<CartProduct> productCart = [];

  List<TextEditingController> notesController = [];
  List<bool> isWriteNote = [];
  bool selectAll = false;
  int totalPrice = 0;

  Future<void> getProduct(int pageKey) async {
    final customer = AppPreference().getUserData();
    try {
      var param = CartProductParam(
          customerId: customer?.user?.id ?? 0, page: pageKey, size: _pageSize);
      final response = await _cartRepository.getCartProduct(param);
      final isLastPage = response.result!.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
        productCart = pagingController.itemList ?? [];
        update();

        setTextEditingController(pagingController.itemList?.length ?? 0);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
        productCart = pagingController.itemList ?? [];
        update();

        setTextEditingController(pagingController.itemList?.length ?? 0);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  setTextEditingController(int lenght) {
    notesController = List.generate(lenght, (index) => TextEditingController());
    isWriteNote = List.generate(lenght, (index) => false);
  }

  Future<bool> updateQty(int id, int qty) async {
    var param = UpdateQtyParam(id: id, qty: qty);
    final response = await _cartRepository.updateQty(param);
    if (response.status == StatusResponse.success) {
      // pagingController.refresh();
      return true;
    } else {
      print("Error : ${response.message}");
      return false;
    }
  }

  Future<bool> updateNote(int id, String note) async {
    var param = UpdateNoteParam(id: id, note: note);
    final response = await _cartRepository.updateNote(param);
    if (response.status == StatusResponse.success) {
      return true;
    } else {
      print("Error : ${response.message}");
      return false;
    }
  }

  Future<bool> deleteBulkProduct(List<int> id) async {
    final response = await _cartRepository.deleteProduct(id);
    if (response.status == StatusResponse.success) {
      return true;
    } else {
      print("Error : ${response.message}");
      return false;
    }
  }

  void selectAllProduct(bool value) {
    selectAll = value;
    totalPrice = 0;
    if (value == false) {
      selectedId.clear();
      update();
    } else {
      selectedId.clear();
      List<int> idProduct =
          productCart.map((product) => product.id ?? 0).toList();
      selectedId.assignAll(idProduct);
      for (var item in productCart) {
        totalPrice += (item.promo ?? 0) * (item.qty ?? 0);
      }

      update();
    }
  }

  void selectProduct(bool value, CartProduct data) {
    selectAll = false;
    if (selectedId.any((e) => e == data.id)) {
      selectedId.removeWhere((e) => e == data.id);
    } else {
      selectedId.add(data.id ?? 0);
    }
    totalPrice = 0;
    for (var item in productCart) {
      if (selectedId.contains(item.id)) {
        totalPrice += (item.promo ?? 0) * (item.qty ?? 0);
      }
    }
    update();
  }

  void selectProductBySeller(bool value, CartProduct data) {
    selectAll = false;
    final selectedItem =
        productCart.where((e) => e.sellerId == data.sellerId).toList();
    List<int> grupId = [];
    for (CartProduct item in selectedItem) {
      if (selectedId.any((e) => e == item.id)) {
        grupId.add(item.sellerId ?? 0);
      }
    }
    for (var item in selectedItem) {
      if (selectedId.any((e) => e == item.id) &&
          productCart.where((e) => e.sellerId == data.sellerId).length !=
              grupId.length) {
        selectedId.removeWhere((e) => e == item.id);
        selectedId.add(item.id ?? 0);
      } else if (selectedId.any((e) => e == item.id) &&
          productCart.where((e) => e.sellerId == data.sellerId).length ==
              grupId.length) {
        selectedId.removeWhere((e) => e == item.id);
      } else {
        selectedId.add(item.id ?? 0);
      }
    }

    totalPrice = 0;
    for (var item in productCart) {
      if (selectedId.contains(item.id)) {
        totalPrice += (item.promo ?? 0) * (item.qty ?? 0);
      }
    }

    update();
  }

  bool selectAllBySeller(CartProduct data) {
    List<int> grupId = [];
    final selectedItem =
        productCart.where((e) => e.sellerId == data.sellerId).toList();
    for (CartProduct item in selectedItem) {
      if (selectedId.any((e) => e == item.id)) {
        grupId.add(item.sellerId ?? 0);
      }
    }
    if (productCart.where((e) => e.sellerId == data.sellerId).length ==
        grupId.length) {
      return true;
    } else {
      return false;
    }
  }

  void deleteProduct(CartProduct value, int index, int id) async {
    bool isDelete = await deleteBulkProduct([id]);
    if (isDelete) {
      pagingController.refresh();
      if (selectedId.any((e) => e == id)) {
        selectedId.removeWhere((e) => e == id);
        await updateTotalPrice();
      } else {
        update();
      }
    } else {
      print("Error Delete");
    }
  }

  void deleteAllProduct() async {
    if (selectedId.isNotEmpty) {
      List<int> idsToDelete = selectedId.map((id) => id).toList();
      bool isDelete = await deleteBulkProduct(idsToDelete);
      if (isDelete) {
        pagingController.refresh();
        selectedId.clear();
        totalPrice = 0;
        update();
      }
    }
  }

  void incrementProduct(int index, int id, int qty) async {
    bool isUpdateQty = await updateQty(id, qty + 1);
    if (isUpdateQty) {
      productCart.where((e) => e.id == id).first.qty = qty + 1;

      update();
      updateTotalPrice();
    }
  }

  void decrementProduct(int index, int id, int qty) async {
    bool isUpdateQty = await updateQty(id, qty - 1);
    if (isUpdateQty) {
      if ((qty - 1) >= 1) {
        productCart.where((e) => e.id == id).first.qty = qty - 1;
        update();
        updateTotalPrice();
      } else {
        bool isDelete = await deleteBulkProduct([id]);
        if (isDelete) {
          selectedId.remove(id);
          pagingController.refresh();
          update();
        }
      }
      updateTotalPrice();
      update();
    }
  }

  updateTotalPrice() {
    totalPrice = 0;
    for (var item in productCart) {
      if (selectedId.contains(item.id)) {
        totalPrice += (item.promo ?? 0) * (item.qty ?? 0);
      }
    }

    update();
  }

  void openWriteNote(int index) {
    isWriteNote[index] = true;
    notesController[index].clear();
    update();
  }

  void closeWriteNote(int index, int id) async {
    isWriteNote[index] = false;
    updateNote(id, notesController[index].text);
    productCart[index].note = notesController[index].text;
    update();
  }

  void buyProduct() {
    List<CartProduct> products = [];
    for (var item in pagingController.itemList ?? []) {
      if (selectedId.contains(item.id)) {
        products.add(item);
      }
    }
    Get.toNamed(Routes.CHECKOUT, arguments: products);
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener((page) {
      getProduct(page);
    });

    super.onInit();
  }
}
