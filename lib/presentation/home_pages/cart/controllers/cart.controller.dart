import 'dart:developer';

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
  // List<int> selectedId = [];
  // List<CartProduct> selectedProduct = [];
  List<CartProduct> productCart = [];
  List<CartProduct> selectProductCart = [];

  List<List<TextEditingController>> notesController = [];
  List<List<bool>> isWriteNote = [];
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
        int productLenght = 0;

        for (CartProduct item in productCart) {
          productLenght += item.products?.length ?? 0;
        }
        setTextEditingController(
            pagingController.itemList?.length ?? 0, productLenght);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
        productCart = pagingController.itemList ?? [];
        update();

        int productLenght = 0;

        for (CartProduct item in productCart) {
          productLenght += item.products?.length ?? 0;
        }
        setTextEditingController(
            pagingController.itemList?.length ?? 0, productLenght);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  setTextEditingController(int lenghtSeller, int lenght) {
    notesController = List.generate(lenghtSeller,
        (index) => List.generate(lenght, (i) => TextEditingController()));
    isWriteNote = List.generate(
        lenghtSeller, (index) => List.generate(lenght, (i) => false));
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
      selectProductCart.clear();
    } else {
      selectProductCart.clear();
      selectProductCart.assignAll(productCart);
      updateTotalPrice();
    }
    update();
  }

  void selectProduct(bool value, CartProduct data, int cartId) {
    selectAll = false;

    bool sellerIdExists =
        selectProductCart.any((e) => e.seller?.id == data.seller?.id);
    bool cartIdExists = selectProductCart
        .any((element) => element.products!.any((p) => p.cartId == cartId));

    if (!sellerIdExists) {
      selectProductCart.add(data);
    } else {
      if (cartIdExists) {
        for (CartProduct item in selectProductCart) {
          if (item.products!.any((p) => p.cartId == cartId)) {
            item.products!.removeWhere((p) => p.cartId == cartId);
            break;
          }
        }
      } else {
        CartProduct existingSeller = selectProductCart
            .firstWhere((e) => e.seller?.id == data.seller?.id);
        existingSeller.products!.add(data.products!.first);
      }
    }

    totalPrice = 0;
    update();
    updateTotalPrice();
  }

  bool isSelectedCartId(int id) {
    return selectProductCart.any((cartProduct) =>
        cartProduct.products!.any((product) => product.cartId == id));
  }

  bool isSelectedAllCartIdBySeller(CartProduct data) {
    int sellerId = data.seller?.id ?? 0;
    int productLength = data.products?.length ?? 0;

    return selectProductCart.any((e) => e.seller?.id == sellerId) &&
        selectProductCart
            .where((p) => p.seller?.id == sellerId)
            .every((p) => p.products?.length == productLength);
  }

  void selectProductBySeller(bool value, CartProduct data) {
    selectAll = false;
    if (selectProductCart
        .any((element) => element.seller?.id == data.seller?.id)) {
      selectProductCart.removeWhere((e) => e.seller?.id == data.seller?.id);
    } else {
      selectProductCart.add(data);
    }
    totalPrice = 0;
    updateTotalPrice();

    update();
  }

  int countProductsBySellerId(int sellerId, CartProduct data) {
    List<Products> products = data.products ?? [];
    int count = 0;
    for (Products product in products) {
      // Selama sellerId pada data produk sama dengan sellerId yang diinginkan, tambahkan ke hitungan
      if (data.seller?.id == sellerId) {
        count++;
      }
    }
    return count;
  }

  void deleteProduct(int index, int id) async {
    bool isDelete = await deleteBulkProduct([id]);
    if (isDelete) {
      pagingController.refresh();
      if (selectProductCart
          .any((e) => e.products!.any((p) => p.cartId == id))) {
        selectProductCart
            .removeWhere((e) => e.products!.any((p) => p.cartId == id));
        await updateTotalPrice();
      } else {
        update();
      }
    } else {
      print("Error Delete");
    }
  }

  void deleteAllProduct() async {
    if (selectProductCart.isNotEmpty) {
      List<int> idsToDelete = [];
      for (CartProduct item in selectProductCart) {
        for (Products data in item.products ?? []) {
          idsToDelete.add(data.cartId ?? 0);
        }
      }
      bool isDelete = await deleteBulkProduct(idsToDelete);
      if (isDelete) {
        pagingController.refresh();
        selectProductCart.clear();
        totalPrice = 0;
        update();
      }
    }
  }

  void incrementProduct(int id, int qty) async {
    bool isUpdateQty = await updateQty(id, qty + 1);
    if (isUpdateQty) {
      for (CartProduct item in productCart) {
        var product = item.products
            ?.firstWhere((e) => e.cartId == id, orElse: () => Products());
        if (product != null) {
          product.qty = qty + 1;
        }
      }
      update();
      updateTotalPrice();
    }
  }

  void decrementProduct(int id, int qty) async {
    bool isUpdateQty = await updateQty(id, qty - 1);
    if (isUpdateQty) {
      if ((qty - 1) >= 1) {
        for (CartProduct item in productCart) {
          var product = item.products
              ?.firstWhere((e) => e.cartId == id, orElse: () => Products());
          if (product != null) {
            product.qty = qty - 1;
          }
        }
        update();
        updateTotalPrice();
      } else {
        bool isDelete = await deleteBulkProduct([id]);
        if (isDelete) {
          selectProductCart.removeWhere(
              (e) => e.products?.any((p) => p.cartId == id) ?? false);
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
    for (CartProduct item in selectProductCart) {
      for (Products product in item.products ?? []) {
        totalPrice += (product.promo ?? 0) * (product.qty ?? 0);
      }
    }
    update();
  }

  void openWriteNote(int indexSeller, int index) {
    isWriteNote[indexSeller][index] = true;
    notesController[indexSeller][index].clear();
    update();
  }

  void closeWriteNote(int indexSeller, int index, int id) async {
    isWriteNote[indexSeller][index] = false;
    updateNote(id, notesController[indexSeller][index].text);
    productCart[indexSeller].products?[index].note =
        notesController[indexSeller][index].text;
    update();
  }

  void buyProduct() {
    Get.toNamed(Routes.CHECKOUT, arguments: selectProductCart);
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
