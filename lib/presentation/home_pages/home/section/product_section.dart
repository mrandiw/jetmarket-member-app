import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/product.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/components/card/product_item.dart';

import 'package:jetmarket/utils/style/app_style.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppStyle.paddingSide16,
      sliver: PagedSliverGrid<int, Product>(
        showNewPageProgressIndicatorAsGridChild: false,
        showNewPageErrorIndicatorAsGridChild: false,
        showNoMoreItemsIndicatorAsGridChild: false,
        pagingController: controller.pagingController,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 100 / 118,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
        ),
        builderDelegate: PagedChildBuilderDelegate<Product>(
            itemBuilder: (context, item, index) => ProductItem(
                item: item,
                onTap: () => controller.toDetailProduct(item.id ?? 0)),
            newPageProgressIndicatorBuilder: (_) {
              return SizedBox(
                height: 120.h,
                child: Center(
                  child: CupertinoActivityIndicator(
                    radius: 12.r,
                  ),
                ),
              );
            },
            firstPageProgressIndicatorBuilder: (_) {
              return Center(
                child: CupertinoActivityIndicator(
                  radius: 12.r,
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return Center(
                child: Text("Oops! Produk belum tersedia",
                    style: text12BlackRegular),
              );
            }),
      ),
    );
  }
}
