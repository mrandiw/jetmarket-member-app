import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/checkout/controllers/checkout.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../widget/delivery_item.dart';
import '../widget/product_item.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingSide16,
      child: GetBuilder<CheckoutController>(builder: (controller) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            var data = controller.productCart[index];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: AppStyle.paddingBottom8,
                  child: Text(
                    data.seller?.name ?? '',
                    style: text12BlackRegular,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Divider(
                  color: kBorder,
                  thickness: 1,
                  height: 0,
                ),
                Column(
                  children: List.generate(
                    data.products?.length ?? 0,
                    (indexProduct) {
                      int indexDelivery = controller.listDelivery.isNotEmpty
                          ? controller.listDelivery
                              .indexWhere((e) => e.sellerId == data.seller?.id)
                          : -1;

                      return Column(
                        children: [
                          ProductItem(
                            data: data.products?[indexProduct],
                            isWriteNote: controller.isWriteNote[index]
                                    [indexProduct] ==
                                false,
                            openWriteNote: () =>
                                controller.openWriteNote(index, indexProduct),
                            closeWriteNote: () => controller.closeWriteNote(
                                index,
                                indexProduct,
                                data.products?[indexProduct].cartId ?? 0),
                            controller: controller.notesController[index]
                                [indexProduct],
                          ),
                          if (indexProduct == data.products!.length - 1 &&
                              controller.listDelivery.isEmpty)
                            Visibility(
                              visible: controller.isLoadingDelivery,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Center(
                                  child: CupertinoActivityIndicator(
                                    radius: 12.r,
                                  ),
                                ),
                              ),
                            ),
                          if (indexProduct == data.products!.length - 1 &&
                              controller.listDelivery.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                children: [
                                  DeliveryItem(
                                    data: controller.listDelivery,
                                    sellerId: data.seller?.id ?? 0,
                                    isExpandedTile:
                                        controller.isExpandedTile[index],
                                    onExpansionChanged: (value) =>
                                        controller.onExpandTile(index),
                                    indexDelivery: index,
                                    excontroller:
                                        controller.excontroller[index],
                                  ),
                                  if (indexDelivery != -1 &&
                                      indexDelivery <
                                          controller.selectedDelivery.length)
                                    _selectedDelivery(
                                        controller, indexDelivery),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                )
              ],
            );
          },
          separatorBuilder: (_, __) => Gap(8.h),
          itemCount: controller.productCart.length,
        );
      }),
    );
  }

  Padding _selectedDelivery(CheckoutController controller, int indexDelivery) {
    return Padding(
      padding: AppStyle.paddingVert12,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyle.borderRadius8All,
        ),
        color: kBorder,
        elevation: 0,
        child: ListTile(
          contentPadding: AppStyle.paddingSide12,
          visualDensity: VisualDensity.compact,
          dense: true,
          title: Text(
            '${controller.selectedDelivery[indexDelivery].packets?.name ?? ''} ${controller.selectedDelivery[indexDelivery].packets?.rate.toString().toIdrFormat ?? ''}',
            style: text12BlackRegular,
          ),
          subtitle: Text(
            controller.selectedDelivery[indexDelivery].packets?.duration ?? '',
            style: text12HintRegular,
          ),
        ),
      ),
    );
  }
}
