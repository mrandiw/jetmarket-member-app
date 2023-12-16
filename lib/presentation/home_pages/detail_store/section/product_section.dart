import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/components/form/app_form_icon.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/home_pages/detail_store/controllers/detail_store.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/card/product_item.dart';
import '../../../../domain/core/model/model_data/product.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key, required this.controller});

  final DetailStoreController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: Padding(
        padding: AppStyle.paddingAll16,
        child: Row(
          children: [
            Expanded(
              child: AppFormIcon(
                controller: controller.searchController,
                icon: search,
                hintText: 'Cari produk',
                onChanged: (value) => controller.searchProducts(value),
              ),
            ),
            Gap(10.wr),
            GestureDetector(
              onTap: () => controller.openFilter(),
              child: Container(
                height: 42.r,
                width: 42.r,
                decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: AppStyle.borderRadius8All,
                    border: AppStyle.borderAll),
                child: Center(
                  child: SvgPicture.asset(miFilter),
                ),
              ),
            )
          ],
        ),
      )),
      SliverPadding(
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
      ),
      SliverToBoxAdapter(
        child: Gap(22.h),
      )
    ]);
  }
}
