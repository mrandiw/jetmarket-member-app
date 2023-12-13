import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

class CartController extends GetxController {
  List<Map<String, dynamic>> dataCarts = [];
  List<TextEditingController> notesController = [];
  List<bool> isWriteNote = [];
  List<dynamic> addForBuy = [];
  bool selectAll = false;
  int totalPrice = 0;

  void selectAllProduct(bool value) {
    selectAll = value;
    totalPrice = 0;
    if (value == false) {
      addForBuy.clear();
      update();
    } else {
      addForBuy.clear();
      addForBuy.assignAll(dataCarts);
      totalPrice = addForBuy.fold(0, (subtotal, element) {
        return subtotal +
            (int.parse(element['promo_price'] ?? '0') * element['total']
                as int);
      });
      update();
    }
  }

  void selectProduct(bool value, dynamic data) {
    selectAll = false;
    if (addForBuy.contains(data)) {
      addForBuy.remove(data);
      update();

      totalPrice = 0;
      for (var item in addForBuy) {
        totalPrice += (int.parse(item['promo_price']) * item['total'] as int);
      }
      update();
    } else {
      addForBuy.add(data);
      update();

      totalPrice = 0;
      for (var item in addForBuy) {
        totalPrice += (int.parse(item['promo_price']) * item['total'] as int);
      }
      update();
    }
  }

  void deleteProduct(dynamic value, int index) {
    print(value);
    dataCarts.removeAt(index);
    update();
    if (addForBuy.contains(value)) {
      addForBuy.remove(value);
      totalPrice = 0;
      for (var item in addForBuy) {
        totalPrice += (int.parse(item['promo_price']) * item['total'] as int);
      }
      update();
    } else {
      update();
    }
  }

  void deleteAllProduct() {
    dataCarts.clear();
    addForBuy.clear();
    totalPrice = 0;
    update();
  }

  void incrementProduct(int index) {
    dataCarts[index]['total']++;
    updateTotalPrice();
    update();
  }

  void decrementProduct(int index) {
    if (dataCarts[index]['total'] > 1) {
      dataCarts[index]['total']--;
      updateTotalPrice();
      update();
    }
  }

  void updateTotalPrice() {
    totalPrice = 0;
    for (var item in addForBuy) {
      totalPrice += (int.parse(item['promo_price']) * item['total'] as int);
    }
    update();
  }

  void openWriteNote(int index) {
    isWriteNote[index] = true;
    update();
  }

  void closeWriteNote(int index) {
    isWriteNote[index] = false;
    dataCarts[index]['note'] = notesController[index].text;
    update();
  }

  void saveNote(index) {
    dataCarts[index]['note'] = notesController[index].text;
    update();
  }

  void buyProduct() {
    Get.toNamed(Routes.CHECKOUT);
  }

  @override
  void onInit() {
    dataCarts = List.generate(
        6,
        (index) => {
              "produc_name": "Produk ${index + 1}",
              "price": "50110",
              "promo_price": "45300",
              "berat": "900",
              "note": "",
              "total": 1
            });
    notesController = List.generate(6, (index) => TextEditingController());
    isWriteNote = List.generate(6, (index) => false);
    super.onInit();
  }
}
