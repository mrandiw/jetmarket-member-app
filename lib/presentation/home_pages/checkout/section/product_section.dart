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
import '../widget/delivery_info_v2.dart';
import '../widget/delivery_date_picker.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(builder: (controller) {
      return Obx(
        () => Column(
          children: [
            // Delivery Date Picker (V2 Only)
            if (controller.useOngkirV2.value)
              Padding(
                padding: AppStyle.paddingSide16,
                child: DeliveryDatePicker(
                  selectedDate: controller.selectedDeliveryDate.value,
                  onDateSelected: (date) => controller.changeDeliveryDate(date),
                ),
              ),
            if (controller.useOngkirV2.value) Gap(8.h),

            // Product List
            Padding(
              padding: AppStyle.paddingSide16,
              child: ListView.separated(
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
                            int indexDelivery =
                                controller.listDelivery.isNotEmpty
                                    ? controller.listDelivery.indexWhere(
                                        (e) => e.sellerId == data.seller?.id)
                                    : -1;

                            return Column(
                              children: [
                                ProductItem(
                                  data: data.products?[indexProduct],
                                  isWriteNote: controller.isWriteNote[index]
                                          [indexProduct] ==
                                      false,
                                  openWriteNote: () => controller.openWriteNote(
                                      index, indexProduct),
                                  closeWriteNote: () =>
                                      controller.closeWriteNote(
                                    index,
                                    indexProduct,
                                    data.products?[indexProduct].cartId ?? 0,
                                  ),
                                  controller: controller.notesController[index]
                                      [indexProduct],
                                  decrement: () => controller.decrementProduct(
                                    data.products?[indexProduct].cartId ?? 0,
                                    data.products?[indexProduct].qty ?? 0,
                                  ),
                                  increment: () => controller.incrementProduct(
                                    data.products?[indexProduct].cartId ?? 0,
                                    data.products?[indexProduct].qty ?? 0,
                                    data.products?[indexProduct].stock ?? 0,
                                  ),
                                  qtyController: controller.qtyControllers[data
                                          .products?[indexProduct].cartId] ??
                                      TextEditingController(
                                        text:
                                            (data.products?[indexProduct].qty ??
                                                    0)
                                                .toString(),
                                      ),
                                  onQtySubmitted: (value) async {
                                    final qtyValue = int.tryParse(value) ?? 0;
                                    final id =
                                        data.products?[indexProduct].cartId ??
                                            0;
                                    final stock =
                                        data.products?[indexProduct].stock ?? 0;

                                    if (qtyValue > stock) {
                                      controller.warningOverStock();
                                      controller.qtyControllers[id]?.text = data
                                              .products?[indexProduct].qty
                                              .toString() ??
                                          '0';
                                    } else if (qtyValue <= 0) {
                                      controller.decrementProduct(
                                          id, 1); // hapus produk
                                    } else {
                                      await controller.updateProductQtyLocally(
                                          id, qtyValue);
                                    }
                                  },
                                ),

                                // Delivery section (last product in seller)
                                if (indexProduct == data.products!.length - 1)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16.0),
                                    child: _buildHybridDelivery(
                                        controller, data, index, indexDelivery),
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
              ),
            ),
          ],
        ),
      );
    });
  }

  // Hybrid Delivery Display - Show V1 (all couriers), add V2 info if JET selected
  Widget _buildHybridDelivery(
    CheckoutController controller,
    dynamic data,
    int index,
    int indexDelivery,
  ) {
    int sellerId = data.seller?.id ?? 0;

    // Check if user selected JET for this seller
    bool isJetSelected = false;
    if (indexDelivery != -1 &&
        indexDelivery < controller.selectedDelivery.length) {
      var selected = controller.selectedDelivery[indexDelivery];
      isJetSelected = selected.packets?.delivery?.code == 'jet';
    }

    return Column(
      children: [
        // Always show V1 (list of all couriers)
        _buildDeliveryV1(controller, data, index, indexDelivery),

        // If JET selected, show V2 tiered pricing info
        if (isJetSelected) _buildJetV2Info(controller, sellerId),
      ],
    );
  }

  // Show JET V2 tiered pricing info
  Widget _buildJetV2Info(CheckoutController controller, int sellerId) {
    var isLoading = controller.ongkirV2Loading[sellerId] ?? false;
    var error = controller.ongkirV2Errors[sellerId];
    var ongkirInfo = controller.ongkirV2Results[sellerId];

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(top: 12.0),
        child: DeliveryInfoLoading(),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: DeliveryInfoError(
          errorMessage: error,
          onRetry: () {
            if (controller.address != null) {
              controller.checkOngkirV2ForSeller(
                sellerId,
                controller.address!.id ?? 0,
              );
            }
          },
        ),
      );
    }

    if (ongkirInfo != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: DeliveryInfoV2(
          ongkirInfo: ongkirInfo,
          selectedTimeSlot: controller.selectedTimeSlots[sellerId],
          onTimeSlotSelected: (timeSlot) =>
              controller.selectTimeSlot(sellerId, timeSlot),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  // V2 Delivery Display
  Widget buildDeliveryV2(CheckoutController controller, dynamic data) {
    int sellerId = data.seller?.id ?? 0;
    var isLoading = controller.ongkirV2Loading[sellerId] ?? false;
    var error = controller.ongkirV2Errors[sellerId];
    var ongkirInfo = controller.ongkirV2Results[sellerId];

    if (isLoading) {
      return const DeliveryInfoLoading();
    }

    if (error != null) {
      return DeliveryInfoError(
        errorMessage: error,
        onRetry: () {
          if (controller.address != null) {
            controller.checkOngkirV2ForSeller(
              sellerId,
              controller.address!.id ?? 0,
            );
          }
        },
      );
    }

    if (ongkirInfo != null) {
      return DeliveryInfoV2(
        ongkirInfo: ongkirInfo,
        selectedTimeSlot: controller.selectedTimeSlots[sellerId],
        onTimeSlotSelected: (timeSlot) =>
            controller.selectTimeSlot(sellerId, timeSlot),
      );
    }

    return const SizedBox.shrink();
  }

  // V1 Delivery Display (old flow)
  Widget _buildDeliveryV1(
    CheckoutController controller,
    dynamic data,
    int index,
    int indexDelivery,
  ) {
    return Column(
      children: [
        // Loading indicator
        if (controller.listDelivery.isEmpty)
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

        // Delivery options
        if (controller.listDelivery.isNotEmpty)
          Column(
            children: [
              DeliveryItem(
                data: controller.listDelivery,
                sellerId: data.seller?.id ?? 0,
                isExpandedTile: controller.isExpandedTile[index],
                onExpansionChanged: (value) => controller.onExpandTile(index),
                indexDelivery: index,
                excontroller: controller.excontroller[index],
              ),
              if (indexDelivery != -1 &&
                  indexDelivery < controller.selectedDelivery.length)
                _selectedDelivery(controller, indexDelivery),
            ],
          ),
      ],
    );
  }

  // Selected delivery card (V1 with V2 rate override for JET)
  Widget _selectedDelivery(CheckoutController controller, int indexDelivery) {
    final selectedDel = controller.selectedDelivery[indexDelivery];
    final sellerId = selectedDel.sellerId ?? 0;
    final isJetCourier = selectedDel.packets?.delivery?.code == 'jet';

    // Use V2 rate for JetKurir if available
    int displayRate = selectedDel.packets?.rate ?? 0;

    // Get V2 info for promo badge
    final v2Result = controller.ongkirV2Results[sellerId];
    final isEligibleFreeOngkir =
        v2Result?.pricing?.isEligibleFreeOngkir ?? true;
    final isInFreeOngkirRange = v2Result?.pricing?.isInFreeOngkirRange ?? false;
    final minPurchaseText = v2Result?.pricing?.minPurchaseText ?? '';

    if (isJetCourier && controller.ongkirV2Results.containsKey(sellerId)) {
      displayRate =
          controller.ongkirV2Results[sellerId]?.pricing?.rate ?? displayRate;
    }

    // Show promo badge if: JET + not eligible + in free range
    final showPromoBadge = isJetCourier &&
        !isEligibleFreeOngkir &&
        isInFreeOngkirRange &&
        minPurchaseText.isNotEmpty;

    return Padding(
      padding: AppStyle.paddingVert12,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: AppStyle.borderRadius8All,
        ),
        color: kBorder,
        elevation: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: AppStyle.paddingSide12,
              visualDensity: VisualDensity.compact,
              dense: true,
              title: Text(
                '${selectedDel.packets?.name ?? ''} ${displayRate.toString().toIdrFormat}',
                style: text12BlackRegular,
              ),
              subtitle: Text(
                selectedDel.packets?.duration ?? '',
                style: text12HintRegular,
              ),
            ),
            // Promo badge for free ongkir
            if (showPromoBadge)
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kSuccessColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: kSuccessColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_offer, size: 12, color: kSuccessColor),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Belanja min. $minPurchaseText untuk GRATIS Ongkir!',
                          style:
                              text10BlackRegular.copyWith(color: kSuccessColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
