import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/params/cart/update_qty_param.dart';
import '../../../../components/dialog/dialog_noconnection.dart';
import '../../../../domain/core/interfaces/cart_repository.dart';
import '../../../../domain/core/interfaces/delivery_repository.dart';
import '../../../../domain/core/model/model_data/address_model.dart';
import '../../../../domain/core/model/model_data/cart_product.dart' as c;
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart' as d;
import '../../../../domain/core/model/params/address/item_product_for_delivery.dart';
import '../../../../domain/core/model/params/cart/update_note_param.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/status_response.dart';

class CheckoutController extends GetxController {
  final DeliveryRepository _deliveryRepository;
  final CartRepository _cartRepository;
  final AddressRepository _addressRepository;
  CheckoutController(
      this._deliveryRepository, this._cartRepository, this._addressRepository);
  List<dynamic> deliverys = [];
  RxList<c.CartProduct> productCart = <c.CartProduct>[].obs;
  List<DeliveryModel> listDelivery = [];
  List<d.SelectDelivery> selectedDelivery = [];
  List<bool> isExpandedTile = [];
  List<List<TextEditingController>> notesController = [];
  List<ExpansionTileController> excontroller = [];
  List<List<bool>> isWriteNote = [];
  AddressModel? address;
  RxDouble totalPrice = 0.0.obs;
  RxDouble totalPriceWithoutVoucher = 0.0.obs;
  RxDouble discount = 0.0.obs;
  RxDouble discountPrice = 0.0.obs;
  int? voucherId;
  String? selectedVouchername;
  bool isLoadingDelivery = false;
  var isLoadingCheck = false.obs;

  Future<void> checkMainAddress() async {
    isLoadingCheck(true);
    final response = await _addressRepository.getAddressHashMain();
    if (response.result == null) {
      Get.toNamed(Routes.EDIT_ADDRESS);
    } else {
      address = response.result;
      update();
      setAddress(address);
    }
    await Future.delayed(200.milliseconds, () {
      isLoadingCheck(false);
    });
  }

  void updateTotalPrice() {
    totalPrice.value = 0.0;
    totalPriceWithoutVoucher.value = 0.0;
    for (c.CartProduct item in productCart) {
      for (c.Products product in item.products ?? []) {
        final total = product.promo != null && product.promo != 0
            ? (product.promo ?? 0)
            : (product.price ?? 0);
        totalPrice.value += total * (product.qty ?? 0);
        totalPriceWithoutVoucher.value += total * (product.qty ?? 0);
      }
    }
    for (d.SelectDelivery item in selectedDelivery) {
      totalPrice.value += item.packets?.rate ?? 0;
      totalPriceWithoutVoucher.value += item.packets?.rate ?? 0;
    }
    totalPrice.value = totalPrice.value -
        (totalPrice.value * discount.value) -
        discountPrice.value;
    totalPriceWithoutVoucher.value = totalPriceWithoutVoucher.value;
    update();
  }

  void toChoicePayment() {
    var dataOrder = dataOrderProduct();
    dataOrder.removeWhere((key, value) =>
        value == null || value == '' || (value is Map && value.isEmpty));

    Get.toNamed(Routes.CHOICE_PAYMENT, arguments: [
      address?.id,
      voucherId,
      address?.personPhone,
      totalPrice.value.toInt(),
      ((totalPriceWithoutVoucher.value) - totalPrice.value).toInt(),
      dataOrder
    ]);

    log(dataOrder.toString());
  }

  Map<String, dynamic> dataOrderProduct() {
    List<dynamic> listItem = [];
    for (int i = 0; i < productCart.length; i++) {
      listItem.add({
        'seller_id': productCart[i].seller?.id,
        'products': List.generate(
            productCart[i].products?.length ?? 0,
            (index) => {
                  'product_name': productCart[i].products?[index].name,
                  'variant_id': productCart[i].products?[index].variantId,
                  'price': productCart[i].products?[index].promo != null &&
                          productCart[i].products![index].promo! > 0
                      ? productCart[i].products![index].promo!
                      : productCart[i].products?[index].price,
                  'quantity': productCart[i].products?[index].qty,
                  'note': productCart[i].products?[index].note ?? ''
                }),
        'delivery': {
          'code': selectedDelivery[i].packets?.delivery?.code,
          'service_name': selectedDelivery[i].packets?.delivery?.serviceName,
          'service_code': selectedDelivery[i].packets?.delivery?.serviceCode,
          'rate': selectedDelivery[i].packets?.rate
        }
      });
    }
    return {'items': listItem};
  }

  int countPrice(int? promo, int? price, int qty) {
    int currentPrice = 0;
    if (promo == 0 || promo == null) {
      currentPrice = price ?? 0;
    } else {
      currentPrice = promo;
    }

    return currentPrice * qty;
  }

  setProduct() {
    productCart.value = Get.arguments;
    int productLenght = 0;
    for (c.CartProduct item in productCart) {
      productLenght += item.products?.length ?? 0;
    }
    setTextEditingController(productCart.length, productLenght);
    update();
    updateTotalPrice();
  }

  selectAddress(AddressModel data) {
    address = data;
    update();
  }

  setAddress(AddressModel? data) {
    listDelivery.clear();
    selectedDelivery.clear();
    if (data != null) {
      address = data;
      isExpandedTile.clear();
      excontroller.clear();
      update();
      var body = setBodyForDelivery(data);
      log(body.toJson().toString());
      isExpandedTile = List.generate(productCart.length, (index) => true);
      excontroller = List.generate(
          productCart.length, (index) => ExpansionTileController());
      getDelivery(body);
    } else {
      address = null;
      update();
    }
  }

  ItemProductForDelivery setBodyForDelivery(AddressModel data) {
    var body = ItemProductForDelivery(
      addressId: data.id,
      items: productCart.map((cartProduct) {
        List<c.Products> filteredProducts = [];
        if (cartProduct.products != null) {
          filteredProducts.addAll(cartProduct.products!);
        }

        List<Products> productsList = filteredProducts.map((product) {
          return Products(
            productName: product.name,
            variantId: product.variantId,
            value: product.promo,
            qty: product.qty,
            note: product.note,
          );
        }).toList();

        return Items(sellerId: cartProduct.seller?.id, products: productsList);
      }).toList(),
    );
    return body;
  }

  Future<void> getDelivery(ItemProductForDelivery body) async {
    isLoadingDelivery = true;
    update();
    final response = await _deliveryRepository.getDelivery(body);
    if (response.status == StatusResponse.success) {
      listDelivery = response.result ?? [];
      isLoadingDelivery = false;

      selectedDelivery.clear();
      final first = _pickFirstSelectDelivery(listDelivery);
      if (first != null) {
        selectedDelivery.add(first);
      }

      update();
    } else if (response.status == StatusResponse.noInternet) {
      if (!(Get.isDialogOpen ?? false)) {
        DialogNoConnection.show(onReload: () {
          Get.back();
          getDelivery(body);
        });
      }
    } else {
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  d.SelectDelivery? _pickFirstSelectDelivery(List<DeliveryModel> sellers) {
    for (final seller in sellers) {
      final services = (seller.services ?? []);
      for (final service in services) {
        final packets = (service.packets ?? []);
        if (packets.isEmpty) continue;
        final packet = packets.first;

        return d.SelectDelivery(
          sellerId: seller.sellerId,
          packets: d.Packets(
            name: packet.name,
            rate: packet.rate,
            duration: packet.duration,
            delivery: d.Delivery(
              code: packet.delivery?.code,
              serviceName: packet.delivery?.code,
              serviceCode: packet.delivery?.code,
            ),
          ),
        );
      }
    }
    return null;
  }

  void updateDeliverySelected(
      {int? sellerId, d.SelectDelivery? delivery, required int index}) {
    controlExpand(index);
    update();
    bool isSellerIdExist = false;
    for (int i = 0; i < selectedDelivery.length; i++) {
      if (selectedDelivery[i].sellerId == sellerId) {
        selectedDelivery[i] = delivery!;
        isSellerIdExist = true;
        break;
      }
    }
    if (!isSellerIdExist) {
      selectedDelivery.add(delivery!);
    }
    update();
    updateTotalPrice();
  }

  void controlExpand(int index) {
    if (excontroller[index].isExpanded) {
      excontroller[index].collapse();
      update();
    } else {
      excontroller[index].expand();
      update();
    }
  }

  void onExpandTile(int index) {
    isExpandedTile[index] = !isExpandedTile[index];
    update();
  }

  setTextEditingController(int lenghtSeller, int lenght) {
    notesController = List.generate(lenghtSeller,
        (index) => List.generate(lenght, (i) => TextEditingController()));
    isWriteNote = List.generate(
        lenghtSeller, (index) => List.generate(lenght, (i) => false));
  }

  void openWriteNote(int indexSeller, int index) {
    String note = productCart[indexSeller].products?[index].note ?? '';
    isWriteNote[indexSeller][index] = true;
    notesController[indexSeller][index].text = note;
    update();
  }

  void closeWriteNote(int indexSeller, int index, int id) async {
    isWriteNote[indexSeller][index] = false;
    updateNote(id, notesController[indexSeller][index].text);
    productCart[indexSeller].products?[index].note =
        notesController[indexSeller][index].text;
    update();
  }

  Future<bool> updateNote(int id, String note) async {
    try {
      bool edited = await updateNoteData(id, note);
      if (edited) {
        for (var item in productCart) {
          var matchingProduct =
              item.products!.firstWhere((e) => e.cartId == id);
          matchingProduct.note = note;
          update();
          return true;
        }
        return false;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateNoteData(int id, String note) async {
    var param = UpdateNoteParam(id: id, note: note);
    final response = await _cartRepository.updateNote(param);
    if (response.status == StatusResponse.success) {
      return true;
    } else {
      return false;
    }
  }

  void selectVoucher(String value) {
    selectedVouchername = value;
    update();
  }

  final qtyControllers = <int, TextEditingController>{}.obs;

  void incrementProduct(int id, int qty, int stock) {
    if (qty >= stock) {
      warningOverStock();
    } else {
      for (int i = 0; i < productCart.length; i++) {
        int? productIndex = productCart[i]
            .products
            ?.indexWhere((product) => product.cartId == id);

        if (productIndex != null && productIndex >= 0) {
          productCart[i] = c.CartProduct(
            seller: productCart[i].seller,
            products: productCart[i].products?.map((product) {
              if (product.cartId == id) {
                qtyControllers[id]?.text = (qty + 1).toString();

                return product.copyWith(qty: product.qty! + 1);
              }
              return product;
            }).toList(),
          );
          break;
        }
      }
      update();
      updateTotalPrice();
    }
  }

  Future<void> updateProductQtyLocally(int id, int newQty) async {
    for (int i = 0; i < productCart.length; i++) {
      int? productIndex = productCart[i]
          .products
          ?.indexWhere((product) => product.cartId == id);

      if (productIndex != null && productIndex >= 0) {
        productCart[i] = c.CartProduct(
          seller: productCart[i].seller,
          products: productCart[i].products?.map((product) {
            if (product.cartId == id) {
              qtyControllers.putIfAbsent(id, () => TextEditingController());
              qtyControllers[id]?.text = newQty.toString();
              return product.copyWith(qty: newQty);
            }
            return product;
          }).toList(),
        );
        break;
      }
    }

    update(); // Untuk GetBuilder
    updateTotalPrice();
  }

  void decrementProduct(int id, int qty) async {
    if ((qty - 1) >= 1) {
      for (int i = 0; i < productCart.length; i++) {
        int? productIndex = productCart[i]
            .products
            ?.indexWhere((product) => product.cartId == id);

        if (productIndex != null && productIndex >= 0) {
          productCart[i] = c.CartProduct(
            seller: productCart[i].seller,
            products: productCart[i].products?.map((product) {
              if (product.cartId == id) {
                qtyControllers[id]?.text = (qty - 1).toString();

                return product.copyWith(qty: product.qty! - 1);
              }
              return product;
            }).toList(),
          );
          break;
        }
      }
      update();
      updateTotalPrice();
    } else {
      update();
    }
  }

  Future<bool> updateQty(int id, int qty) async {
    var param = UpdateQtyParam(id: id, qty: qty);
    final response = await _cartRepository.updateQty(param);
    if (response.status == StatusResponse.success) {
      // pagingController.refresh();
      return true;
    } else {
      return false;
    }
  }

  void warningOverStock() {
    AppSnackbar.show(message: 'Stok tidak mencukupi', type: SnackType.error);
  }

  @override
  void onInit() {
    checkMainAddress();
    setProduct();

    super.onInit();
  }
}
