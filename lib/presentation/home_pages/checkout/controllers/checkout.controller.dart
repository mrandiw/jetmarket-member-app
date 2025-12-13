import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/domain/core/interfaces/address_repository.dart';
import 'package:jetmarket/domain/core/model/params/cart/update_qty_param.dart';
import '../../../../components/dialog/dialog_noconnection.dart';
import '../../../../domain/core/interfaces/cart_repository.dart';
import '../../../../domain/core/interfaces/delivery_repository.dart';
import '../../../../domain/core/model/model_data/address_model.dart';
import '../../../../domain/core/model/model_data/cart_product.dart' as c;
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../domain/core/model/model_data/ongkir_v2_response.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart' as d;
import '../../../../domain/core/model/params/address/item_product_for_delivery.dart';
import '../../../../domain/core/model/params/cart/update_note_param.dart';
import '../../../../domain/core/model/params/delivery/check_ongkir_v2_param.dart';
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

  // ========== NEW: Ongkir V2 Variables ==========
  /// Map untuk menyimpan hasil check ongkir V2 per seller
  /// Key: seller_id, Value: OngkirV2Response
  RxMap<int, OngkirV2Response> ongkirV2Results = <int, OngkirV2Response>{}.obs;

  /// Map untuk menyimpan time slot yang dipilih per seller
  /// Key: seller_id, Value: TimeSlot
  RxMap<int, TimeSlot?> selectedTimeSlots = <int, TimeSlot?>{}.obs;

  /// Tanggal pengiriman yang dipilih (default: besok)
  late Rx<DateTime> selectedDeliveryDate;

  /// Loading state untuk check ongkir V2 per seller
  /// Key: seller_id, Value: isLoading
  RxMap<int, bool> ongkirV2Loading = <int, bool>{}.obs;

  /// Error message untuk check ongkir V2 per seller
  /// Key: seller_id, Value: error message
  RxMap<int, String?> ongkirV2Errors = <int, String?>{}.obs;

  /// Flag untuk menggunakan V2 atau V1
  /// false = default (show all couriers), true = use V2 when JET selected
  RxBool useOngkirV2 = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize delivery date to tomorrow
    selectedDeliveryDate = DateTime.now().add(const Duration(days: 1)).obs;

    // Run initial checks
    checkMainAddress();
    setProduct();
  }

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

    // Calculate product price
    for (c.CartProduct item in productCart) {
      for (c.Products product in item.products ?? []) {
        final total = product.promo != null && product.promo != 0
            ? (product.promo ?? 0)
            : (product.price ?? 0);
        totalPrice.value += total * (product.qty ?? 0);
        totalPriceWithoutVoucher.value += total * (product.qty ?? 0);
      }
    }

    // Add delivery cost
    for (d.SelectDelivery item in selectedDelivery) {
      int sellerId = item.sellerId ?? 0;
      int deliveryRate = item.packets?.rate ?? 0;

      // ⭐ If this is JET courier and V2 result exists, use V2 rate instead
      if (item.packets?.delivery?.code == 'jet' &&
          ongkirV2Results.containsKey(sellerId)) {
        deliveryRate = ongkirV2Results[sellerId]?.pricing?.rate ?? deliveryRate;
      }

      totalPrice.value += deliveryRate;
      totalPriceWithoutVoucher.value += deliveryRate;
    }

    // Apply discounts
    totalPrice.value = totalPrice.value -
        (totalPrice.value * discount.value) -
        discountPrice.value;
    totalPriceWithoutVoucher.value = totalPriceWithoutVoucher.value;
    update();
  }

  // ========== ONGKIR V2 METHODS ==========

  /// ⭐ NEW: Calculate total items price for a specific seller
  /// Used for min_purchase validation in free ongkir
  int calculateTotalItemsPriceForSeller(int sellerId) {
    int total = 0;
    for (c.CartProduct item in productCart) {
      if (item.seller?.id == sellerId) {
        for (c.Products product in item.products ?? []) {
          final price = product.promo != null && product.promo != 0
              ? (product.promo ?? 0)
              : (product.price ?? 0);
          total += price * (product.qty ?? 0);
        }
      }
    }
    return total;
  }

  /// Check ongkir V2 untuk satu seller
  Future<void> checkOngkirV2ForSeller(int sellerId, int addressId) async {
    try {
      // Set loading state
      ongkirV2Loading[sellerId] = true;
      ongkirV2Errors[sellerId] = null;
      update();

      // ⭐ Calculate total items price for this seller (for min_purchase validation)
      final totalItemsPrice = calculateTotalItemsPriceForSeller(sellerId);

      // Prepare parameter
      final param = CheckOngkirV2Param(
        addressId: addressId,
        sellerId: sellerId,
        deliveryDate: _formatDateForApi(selectedDeliveryDate.value),
        totalItemsPrice:
            totalItemsPrice, // ⭐ NEW: Pass for min_purchase validation
      );

      // Validate parameter
      if (!param.isValid()) {
        ongkirV2Errors[sellerId] = param.getValidationError();
        ongkirV2Loading[sellerId] = false;
        update();
        return;
      }

      // Call API
      final response = await _deliveryRepository.checkOngkirV2(param);

      if (response.status == StatusResponse.success &&
          response.result != null) {
        // Success - save result
        ongkirV2Results[sellerId] = response.result!;
        ongkirV2Errors[sellerId] = null;

        // If free ongkir and has time slots, clear previous selection
        if (response.result!.pricing?.requireTimeSlot == true) {
          selectedTimeSlots[sellerId] = null;
        }

        // ⭐ Update total price to reflect V2 rate for JET
        updateTotalPrice();

        log('✅ Ongkir V2 Success for seller $sellerId: ${response.result!.pricing?.rate}');
      } else if (response.status == StatusResponse.noInternet) {
        ongkirV2Errors[sellerId] = 'Tidak ada koneksi internet';
        if (!(Get.isDialogOpen ?? false)) {
          DialogNoConnection.show(onReload: () {
            Get.back();
            checkOngkirV2ForSeller(sellerId, addressId);
          });
        }
      } else {
        // Error
        ongkirV2Errors[sellerId] =
            response.message ?? 'Gagal mendapatkan info ongkir';
        log('❌ Ongkir V2 Error for seller $sellerId: ${response.message}');
      }
    } catch (e) {
      ongkirV2Errors[sellerId] = 'Terjadi kesalahan: ${e.toString()}';
      log('❌ Exception checking ongkir V2 for seller $sellerId: $e');
    } finally {
      ongkirV2Loading[sellerId] = false;
      update();
      updateTotalPriceV2();
    }
  }

  /// Check ongkir V2 untuk semua seller di cart
  Future<void> checkOngkirV2ForAllSellers() async {
    if (address == null) {
      AppSnackbar.show(
        message: 'Pilih alamat pengiriman terlebih dahulu',
        type: SnackType.error,
      );
      return;
    }

    // Clear previous results
    ongkirV2Results.clear();
    selectedTimeSlots.clear();
    ongkirV2Errors.clear();

    // Check untuk setiap seller secara parallel
    final futures = <Future>[];
    for (var cartProduct in productCart) {
      final sellerId = cartProduct.seller?.id;
      if (sellerId != null) {
        futures.add(checkOngkirV2ForSeller(sellerId, address!.id!));
      }
    }

    await Future.wait(futures);
  }

  /// Select time slot untuk seller tertentu
  void selectTimeSlot(int sellerId, TimeSlot slot) {
    selectedTimeSlots[sellerId] = slot;
    update();
    log('✅ Selected time slot for seller $sellerId: ${slot.name}');
  }

  /// Change delivery date dan re-check ongkir
  Future<void> changeDeliveryDate(DateTime newDate) async {
    selectedDeliveryDate.value = newDate;
    update();

    log('📅 Delivery date changed to: ${_formatDateForApi(newDate)}');

    // Re-check ongkir untuk semua seller karena quota bisa berbeda per tanggal
    if (address != null) {
      await checkOngkirV2ForAllSellers();
    }
  }

  /// Update total price dengan ongkir V2
  void updateTotalPriceV2() {
    totalPrice.value = 0.0;
    totalPriceWithoutVoucher.value = 0.0;

    // Calculate product price
    for (c.CartProduct item in productCart) {
      for (c.Products product in item.products ?? []) {
        final total = product.promo != null && product.promo != 0
            ? (product.promo ?? 0)
            : (product.price ?? 0);
        totalPrice.value += total * (product.qty ?? 0);
        totalPriceWithoutVoucher.value += total * (product.qty ?? 0);
      }
    }

    // Add shipping cost dari V2
    for (var entry in ongkirV2Results.entries) {
      final rate = entry.value.pricing?.rate ?? 0;
      totalPrice.value += rate;
      totalPriceWithoutVoucher.value += rate;
    }

    // Apply voucher discount
    totalPrice.value = totalPrice.value -
        (totalPrice.value * discount.value) -
        discountPrice.value;

    update();
  }

  /// Format date untuk API (YYYY-MM-DD)
  String _formatDateForApi(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  /// Get ongkir info untuk seller tertentu
  OngkirV2Response? getOngkirV2ForSeller(int sellerId) {
    return ongkirV2Results[sellerId];
  }

  /// Check if seller has free ongkir
  bool isFreeOngkirForSeller(int sellerId) {
    final ongkir = ongkirV2Results[sellerId];
    return ongkir?.pricing?.isFreeOngkir == true;
  }

  /// Check if seller requires time slot
  bool requiresTimeSlotForSeller(int sellerId) {
    final ongkir = ongkirV2Results[sellerId];
    return ongkir?.pricing?.requireTimeSlot == true;
  }

  // ⭐ NEW: Min purchase helper methods

  /// Check if customer is eligible for free ongkir for seller
  bool isEligibleFreeOngkirForSeller(int sellerId) {
    final ongkir = ongkirV2Results[sellerId];
    return ongkir?.pricing?.isEligibleFreeOngkir == true;
  }

  /// Get minimum purchase amount for free ongkir for seller
  int getMinPurchaseForSeller(int sellerId) {
    final ongkir = ongkirV2Results[sellerId];
    return ongkir?.pricing?.minPurchase ?? 0;
  }

  /// Get formatted minimum purchase text for seller (e.g., "Rp50.000")
  String getMinPurchaseTextForSeller(int sellerId) {
    final ongkir = ongkirV2Results[sellerId];
    return ongkir?.pricing?.minPurchaseText ?? '';
  }

  /// Get remaining amount needed to qualify for free ongkir
  int getRemainingForFreeOngkir(int sellerId) {
    final minPurchase = getMinPurchaseForSeller(sellerId);
    final currentTotal = calculateTotalItemsPriceForSeller(sellerId);
    final remaining = minPurchase - currentTotal;
    return remaining > 0 ? remaining : 0;
  }

  /// Check if customer is close to qualifying for free ongkir (within 20%)
  bool isCloseToFreeOngkir(int sellerId) {
    final minPurchase = getMinPurchaseForSeller(sellerId);
    if (minPurchase == 0) return false;
    final currentTotal = calculateTotalItemsPriceForSeller(sellerId);
    final percentage = (currentTotal / minPurchase) * 100;
    return percentage >= 80 && percentage < 100;
  }

  /// Check if all required time slots are selected
  bool allRequiredTimeSlotsSelected() {
    for (var entry in ongkirV2Results.entries) {
      final sellerId = entry.key;
      final ongkir = entry.value;

      if (ongkir.pricing?.requireTimeSlot == true) {
        if (selectedTimeSlots[sellerId] == null) {
          return false;
        }
      }
    }
    return true;
  }

  // ========== END ONGKIR V2 METHODS ==========

  /// Validate checkout before proceeding to payment (V2)
  bool validateCheckoutV2() {
    // Check if address selected
    if (address == null) {
      AppSnackbar.show(
        message: 'Pilih alamat pengiriman terlebih dahulu',
        type: SnackType.error,
      );
      return false;
    }

    // Check semua seller sudah ada ongkir info
    for (var cartProduct in productCart) {
      int sellerId = cartProduct.seller?.id ?? 0;

      if (!ongkirV2Results.containsKey(sellerId)) {
        AppSnackbar.show(
          message:
              'Gagal mendapatkan info ongkir untuk ${cartProduct.seller?.name}',
          type: SnackType.error,
        );
        return false;
      }

      // Check if ada error
      if (ongkirV2Errors[sellerId] != null) {
        AppSnackbar.show(
          message: 'Error ongkir: ${ongkirV2Errors[sellerId]}',
          type: SnackType.error,
        );
        return false;
      }

      // ⭐ NEW: Jika free ongkir tapi tidak eligible, pastikan user tau bayar ongkir
      final ongkirInfo = ongkirV2Results[sellerId];
      if (ongkirInfo?.pricing?.isFreeOngkir == true &&
          ongkirInfo?.pricing?.isEligibleFreeOngkir == false) {
        // User tidak memenuhi minimum purchase - ini OK, mereka bayar ongkir
        // Tapi pastikan mereka tidak perlu pilih time slot
        log('⚠️ Seller $sellerId: Not eligible for free ongkir, paying ${ongkirInfo?.pricing?.rate}');
      }

      // Jika eligible free ongkir dan require time slot, pastikan time slot sudah dipilih
      if (ongkirV2Results[sellerId]?.pricing?.requireTimeSlot == true &&
          ongkirV2Results[sellerId]?.pricing?.isEligibleFreeOngkir == true) {
        if (selectedTimeSlots[sellerId] == null) {
          AppSnackbar.show(
            message: 'Pilih waktu pengiriman untuk ${cartProduct.seller?.name}',
            type: SnackType.error,
          );
          return false;
        }
      }
    }

    return true;
  }

  /// Create order data with V2 structure
  Map<String, dynamic> dataOrderProductV2() {
    List<dynamic> listItem = [];

    for (int i = 0; i < productCart.length; i++) {
      int sellerId = productCart[i].seller?.id ?? 0;
      var ongkirInfo = ongkirV2Results[sellerId];
      var timeSlot = selectedTimeSlots[sellerId];

      listItem.add({
        'seller_id': sellerId,
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
          },
        ),
        'delivery': {
          'courier_code': 'jetkurir', // atau dari config
          'rate': ongkirInfo?.pricing?.rate ?? 0,

          // NEW FIELDS untuk V2
          if (timeSlot != null) 'time_slot_id': timeSlot.id,
          'scheduled_date': _formatDateForApi(selectedDeliveryDate.value),
          if (ongkirInfo?.distance?.meters != null)
            'distance_meters': ongkirInfo!.distance!.meters,
          if (ongkirInfo?.distance?.text != null)
            'distance_text': ongkirInfo!.distance!.text,
          if (ongkirInfo?.distance?.duration != null)
            'duration_text': ongkirInfo!.distance!.duration,
          if (ongkirInfo?.pricing?.tierId != null)
            'pricing_tier_id': ongkirInfo!.pricing!.tierId,
        }
      });
    }

    return {'items': listItem};
  }

  void toChoicePayment() {
    // HYBRID: Build order data dengan V1 + V2 (JET dengan tiered pricing)
    var dataOrder = dataOrderProductHybrid();
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

    log('✅ Order data (Hybrid): ${dataOrder.toString()}');
  }

  /// Build order data dengan hybrid (V1 + V2) logic
  Map<String, dynamic> dataOrderProductHybrid() {
    List<dynamic> listItem = [];

    debugPrint('🔍 ========== dataOrderProductHybrid() START ==========');
    debugPrint('🔍 productCart.length: ${productCart.length}');
    debugPrint('🔍 ongkirV2Results keys: ${ongkirV2Results.keys.toList()}');
    debugPrint('🔍 selectedTimeSlots: $selectedTimeSlots');

    for (int i = 0; i < productCart.length; i++) {
      int sellerId = productCart[i].seller?.id ?? 0;

      // Find selected delivery for this seller
      var selectedDel = selectedDelivery.firstWhere(
        (d) => d.sellerId == sellerId,
        orElse: () => d.SelectDelivery(),
      );

      debugPrint(
          '🔍 Seller[$sellerId] selectedDel.code: ${selectedDel.packets?.delivery?.code}');
      debugPrint(
          '🔍 Seller[$sellerId] hasV2Result: ${ongkirV2Results.containsKey(sellerId)}');

      // Check apakah JET dipilih dan hasil V2 ada.
      bool isJetWithV2 = selectedDel.packets?.delivery?.code == 'jet' &&
          ongkirV2Results.containsKey(sellerId);

      debugPrint('🔍 Seller[$sellerId] isJetWithV2: $isJetWithV2');

      // ⭐ DEBUG: Log time slot
      var timeSlotDebug = selectedTimeSlots[sellerId];
      debugPrint(
          '🔍 Seller[$sellerId] timeSlot: id=${timeSlotDebug?.id}, name=${timeSlotDebug?.name}');

      Map<String, dynamic> orderItem = {
        'seller_id': sellerId,
        'products': List.generate(
          productCart[i].products?.length ?? 0,
          (j) => {
            'product_name': productCart[i].products?[j].name,
            'variant_id': productCart[i].products?[j].variantId,
            'price': productCart[i].products?[j].promo ??
                productCart[i].products?[j].price,
            'quantity': productCart[i].products?[j].qty,
            'note': productCart[i].products?[j].note,
          },
        ),
      };

      if (isJetWithV2) {
        // Use V2 data for JET
        var ongkirInfo = ongkirV2Results[sellerId];
        var timeSlot = selectedTimeSlots[sellerId];

        // ⭐ Build delivery object with time_slot_id and scheduled_date INSIDE
        Map<String, dynamic> deliveryData = {
          'code': 'jet',
          'rate': ongkirInfo?.pricing?.rate,
          'service_name': 'JetKurir',
          'service_code': 'INSTANT',
        };

        // ⭐ Add time_slot_id INSIDE delivery object (required by backend)
        if (timeSlot != null) {
          deliveryData['time_slot_id'] = timeSlot.id;
          debugPrint('✅ Added time_slot_id: ${timeSlot.id}');
        } else {
          debugPrint('⚠️ timeSlot is NULL for seller $sellerId');
        }

        // ⭐ Add scheduled_date INSIDE delivery object (required by backend)
        deliveryData['scheduled_date'] =
            _formatDateForApi(selectedDeliveryDate.value);

        orderItem['delivery'] = deliveryData;

        // V2 metadata (these stay at orderItem level for logging/tracking)
        orderItem['distance_meters'] = ongkirInfo?.distance?.meters;
        orderItem['distance_text'] = ongkirInfo?.distance?.text;
        orderItem['duration_text'] = ongkirInfo?.distance?.duration;

        if (ongkirInfo?.pricing?.tierId != null) {
          orderItem['pricing_tier_id'] = ongkirInfo!.pricing!.tierId;
        }

        // ⭐ DEBUG: Log delivery data untuk JET
        debugPrint('========== DEBUG ORDER ITEM (JET V2) ==========');
        debugPrint('SellerId: $sellerId');
        debugPrint('Delivery object: ${orderItem['delivery']}');
        debugPrint('TimeSlot: ${timeSlot?.id} - ${timeSlot?.name}');
        debugPrint('ScheduledDate: ${selectedDeliveryDate.value}');
        debugPrint(
            'OngkirInfo: isEligibleFreeOngkir=${ongkirInfo?.pricing?.isEligibleFreeOngkir}');
        debugPrint('OngkirInfo: rate=${ongkirInfo?.pricing?.rate}');
        debugPrint('==============================================');
      } else {
        // Use V1 data untuk couriers lain (JNE, Grab, Gojek, Self Pickup)
        orderItem['delivery'] = {
          'code': selectedDel.packets?.delivery?.code,
          'rate': selectedDel.packets?.rate,
          'service_name': selectedDel.packets?.delivery?.serviceName,
          'service_code': selectedDel.packets?.delivery?.serviceCode,
        };
      }

      listItem.add(orderItem);
    }

    debugPrint('🔍 ========== dataOrderProductHybrid() END ==========');

    return {'items': listItem};
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

      // Clear previous V2 results
      ongkirV2Results.clear();
      selectedTimeSlots.clear();
      ongkirV2Loading.clear();
      ongkirV2Errors.clear();

      if (useOngkirV2.value) {
        // V2: Check ongkir for all sellers
        checkOngkirV2ForAllSellers();
      } else {
        // V1: Old flow
        var body = setBodyForDelivery(data);
        log(body.toJson().toString());
        isExpandedTile = List.generate(productCart.length, (index) => true);
        excontroller = List.generate(
            productCart.length, (index) => ExpansionTileController());
        getDelivery(body);
      }
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

      // ⭐ NEW: Auto-check ongkir V2 for all sellers after delivery list is loaded
      // This ensures V2 rates are available before user selects any delivery option
      if (address != null) {
        checkOngkirV2ForAllSellers();
      }
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

    // ⭐ NEW: Check if selected courier is JET
    if (delivery?.packets?.delivery?.code == 'jet' && sellerId != null) {
      // Trigger V2 ongkir check for JET
      _checkOngkirV2ForJetCourier(sellerId);
    } else {
      // Clear V2 data for this seller if courier is not JET
      ongkirV2Results.remove(sellerId);
      selectedTimeSlots.remove(sellerId);
      ongkirV2Loading.remove(sellerId);
      ongkirV2Errors.remove(sellerId);
      update();
    }
  }

  /// Check ongkir V2 specifically when user selects JET courier
  Future<void> _checkOngkirV2ForJetCourier(int sellerId) async {
    if (address == null) return;

    // Call V2 API for this seller
    await checkOngkirV2ForSeller(sellerId, address!.id ?? 0);
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

  /// ⭐ Re-check ongkir V2 for a specific seller after quantity change
  /// This ensures free ongkir eligibility is updated when cart total changes
  Future<void> _recheckOngkirV2ForProduct(int cartId) async {
    if (address == null) return;

    // Find seller ID for this product
    int? sellerId;
    for (var cartProduct in productCart) {
      final hasProduct =
          cartProduct.products?.any((p) => p.cartId == cartId) ?? false;
      if (hasProduct) {
        sellerId = cartProduct.seller?.id;
        break;
      }
    }

    if (sellerId != null) {
      // Re-check V2 for this seller with updated totalItemsPrice
      await checkOngkirV2ForSeller(sellerId, address!.id ?? 0);
    }
  }

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

      // ⭐ Re-check ongkir V2 to update free ongkir eligibility
      _recheckOngkirV2ForProduct(id);
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

      // ⭐ Re-check ongkir V2 to update free ongkir eligibility
      _recheckOngkirV2ForProduct(id);
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
}
