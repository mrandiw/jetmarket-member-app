import 'package:get/get.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import '../../../../domain/core/interfaces/delivery_repository.dart';
import '../../../../domain/core/model/model_data/address_model.dart';
import '../../../../domain/core/model/model_data/cart_product.dart' as c;
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart' as d;
import '../../../../domain/core/model/params/address/item_product_for_delivery.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../utils/network/status_response.dart';

class CheckoutController extends GetxController {
  final DeliveryRepository _deliveryRepository;
  CheckoutController(this._deliveryRepository);
  List<dynamic> deliverys = [];
  List<c.CartProduct> productCart = [];
  List<DeliveryModel> listDelivery = [];
  List<d.SelectDelivery> selectedDelivery = [];
  List<bool> isExpandedTile = [];
  AddressModel? address;
  double totalPrice = 0.0;
  double discount = 0.0;
  int? voucherId;

  void updateTotalPrice() {
    totalPrice = 0.0;
    for (c.CartProduct item in productCart) {
      for (c.Products product in item.products ?? []) {
        totalPrice += (product.promo ?? 0) * (product.qty ?? 0);
      }
    }
    for (d.SelectDelivery item in selectedDelivery) {
      totalPrice += item.packets?.rate ?? 0;
    }
    totalPrice = totalPrice - (totalPrice * discount);
    update();
  }

  void toChoicePayment() {
    Get.toNamed(Routes.CHOICE_PAYMENT, arguments: [
      address?.id,
      voucherId,
      address?.personPhone,
      totalPrice.toInt(),
      dataOrderProduct()
    ]);
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
                  'price': productCart[i].products?[index].promo ??
                      productCart[i].products?[index].price,
                  'quantity': productCart[i].products?[index].qty
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
    productCart = Get.arguments;
    update();
    updateTotalPrice();
  }

  selectAddress(AddressModel data) {
    address = data;
    update();
  }

  setAddress() {
    AddressModel? data = AppPreference().getAddress();
    selectedDelivery.clear();
    if (data != null) {
      address = data;
      update();
      var body = setBodyForDelivery(data);
      isExpandedTile = List.generate(productCart.length, (index) => false);
      getDelivery(body);
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
            variantId: product.variantId,
            value: product.promo,
            qty: product.qty,
          );
        }).toList();

        return Items(sellerId: cartProduct.seller?.id, products: productsList);
      }).toList(),
    );
    return body;
  }

  Future<void> getDelivery(ItemProductForDelivery body) async {
    final response = await _deliveryRepository.getDelivery(body);
    if (response.status == StatusResponse.success) {
      listDelivery = response.result ?? [];
      update();
    } else {
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  void updateDeliverySelected({int? sellerId, d.SelectDelivery? delivery}) {
    isExpandedTile.clear();
    isExpandedTile = List.generate(productCart.length, (index) => false);
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

  void onExpandTile(int index) {
    isExpandedTile[index] = !isExpandedTile[index];
    update();
  }

  @override
  void onInit() {
    setProduct();
    setAddress();

    super.onInit();
  }
}
