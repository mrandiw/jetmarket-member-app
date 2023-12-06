import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/presentation/cart/section/list_product.dart';

import 'controllers/cart.controller.dart';
import 'section/app_bar_section.dart';
import 'section/footer_section.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarCart,
      body: ListView(
        children: const [ListProduct()],
      ),
      bottomNavigationBar: const FooterSection(),
    );
  }
}
