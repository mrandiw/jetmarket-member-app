import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import 'controllers/product_bycategory.controller.dart';
import 'section/app_bar_section.dart';
import 'section/product_section.dart';

class ProductBycategoryScreen extends GetView<ProductBycategoryController> {
  const ProductBycategoryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarProductCategory,
        body: ListView(
          padding: AppStyle.paddingAll16,
          children: const [ProductSection()],
        ));
  }
}
