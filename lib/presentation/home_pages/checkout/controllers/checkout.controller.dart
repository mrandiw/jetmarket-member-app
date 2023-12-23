import 'package:get/get.dart';
import '../../../../domain/core/model/model_data/address_model.dart';
import '../../../../domain/core/model/model_data/cart_product.dart';
import '../../../../infrastructure/navigation/routes.dart';

class CheckoutController extends GetxController {
  List<dynamic> deliverys = [];
  List<CartProduct> productCart = [];
  int selectedDelivery = 99;
  AddressModel? address;
  double totalPrice = 0.0;
  double discount = 0.0;

  void updateTotalPrice() {
    totalPrice = 0.0;
    for (var item in productCart) {
      totalPrice += (item.promo ?? 0) * (item.qty ?? 0);
    }
    totalPrice = totalPrice - (totalPrice * discount);
    update();
  }

  void selectDelivery(int value) {
    if (selectedDelivery != value) {
      selectedDelivery = value;
      update();
    } else {
      selectedDelivery = 99;
      update();
    }
  }

  void toChoicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT);
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
    productCart = Get.arguments;
    update();
    updateTotalPrice();
  }

  void incrementProduct(int index, int id, int qty) async {
    productCart.where((e) => e.id == id).first.qty = qty + 1;
    update();
    updateTotalPrice();
  }

  void decrementProduct(int index, int id, int qty) async {
    // jika qty == 1 maka delete
    if ((qty - 1) >= 1) {
      productCart.where((e) => e.id == id).first.qty = qty - 1;
      update();
      updateTotalPrice();
    } else {
      productCart.removeWhere((e) => e.id == id);
      update();
      updateTotalPrice();
    }
  }

  selectAddress(AddressModel data) {
    address = data;
    update();
  }

  @override
  void onInit() {
    setProduct();
    deliverys = List.generate(
        3,
        (index) => {
              "name": "Pengiriman ${index + 1}",
              "price": 20000,
              "estimasi": "16 - 20"
            });
    super.onInit();
  }
}
