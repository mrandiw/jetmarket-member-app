import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/presentation/home_pages/product_bycategory/controllers/product_bycategory.controller.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../components/card/product_item.dart';
import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../domain/core/model/model_data/product.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.controller});
  final ProductBycategoryController controller;

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
            newPageProgressIndicatorBuilder: InfinitiPage.progress,
            firstPageProgressIndicatorBuilder: InfinitiPage.progress,
            noItemsFoundIndicatorBuilder: (_) =>
                InfinitiPage.empty(_, 'Produk'),
            firstPageErrorIndicatorBuilder: InfinitiPage.error),
      ),
    );
  }
}
