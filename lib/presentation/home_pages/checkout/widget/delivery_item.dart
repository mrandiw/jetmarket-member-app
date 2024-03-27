import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/expansion/custom_expansion.dart';

import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../domain/core/model/model_data/delivery_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class DeliveryItem extends StatelessWidget {
  const DeliveryItem(
      {super.key,
      required this.data,
      required this.sellerId,
      required this.isExpandedTile,
      this.onExpansionChanged,
      required this.indexDelivery,
      this.excontroller});

  final List<DeliveryModel> data;
  final int sellerId;
  final bool isExpandedTile;
  final Function(bool)? onExpansionChanged;
  final int indexDelivery;
  final ExpansionTileController? excontroller;

  @override
  Widget build(BuildContext context) {
    return CustomExpansion(
      title: 'Pengiriman',
      isExpanded: isExpandedTile,
      onTap: () {},
      onExpansionChanged: onExpansionChanged,
      content: Column(
        children: data
            .where((delivery) => delivery.sellerId == sellerId)
            .map((delivery) => Column(
                children: List.generate(
                    delivery.services?.length ?? 0,
                    (index) => Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius8All,
                          ),
                          color: kWhite,
                          child: ListTile(
                            onTap: () {
                              List<dynamic>? packets =
                                  delivery.services?[index].packets;
                              String packetsJson = jsonEncode(packets);
                              Get.toNamed(Routes.CHOICE_DELIVERY, arguments: [
                                sellerId,
                                packetsJson,
                                indexDelivery
                              ]);
                            },
                            visualDensity: VisualDensity.compact,
                            dense: true,
                            title: Text(
                                '${'${delivery.services?[index].name}'.toUpperCase()} (${delivery.services?[index].rate.toString().toIdrFormat})',
                                style: text12BlackRegular),
                            subtitle: Text(
                              '${delivery.services?[index].duration}',
                              style: text12HintRegular,
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 14.wr,
                            ),
                          ),
                        ))))
            .toList(),
      ),
    );
    // return Column(
    //   children: [
    //     SizedBox(
    //       width: Get.width.wr,
    //       child: Theme(
    //         data: Theme.of(context).copyWith(
    //             dividerColor: Colors.transparent,
    //             highlightColor: kWhite,
    //             hoverColor: kWhite,
    //             focusColor: kWhite,
    //             materialTapTargetSize: MaterialTapTargetSize.padded,
    //             splashColor: kWhite),
    //         child: ExpansionTile(
    //           title: Text(
    //             'Pengiriman',
    //             style: text12BlackSemiBold,
    //           ),
    //           iconColor: kBlack,
    //           tilePadding: EdgeInsets.zero,
    //           initiallyExpanded: isExpandedTile,
    //           onExpansionChanged: onExpansionChanged,
    //           maintainState: isExpandedTile,
    //           controller: excontroller,
    //           children: [
    //             Container(
    //               width: Get.width.wr,
    //               padding: AppStyle.paddingAll8,
    //               decoration: BoxDecoration(
    //                 color: kBorder,
    //                 borderRadius: AppStyle.borderRadius8All,
    //               ),
    //               child: Column(
    //                 children: data
    //                     .where((delivery) => delivery.sellerId == sellerId)
    //                     .map((delivery) => Column(
    //                         children: List.generate(
    //                             delivery.services?.length ?? 0,
    //                             (index) => Card(
    //                                   elevation: 0,
    //                                   shape: RoundedRectangleBorder(
    //                                     borderRadius: AppStyle.borderRadius8All,
    //                                   ),
    //                                   color: kWhite,
    //                                   child: ListTile(
    //                                     onTap: () {
    //                                       List<dynamic>? packets =
    //                                           delivery.services?[index].packets;
    //                                       String packetsJson =
    //                                           jsonEncode(packets);
    //                                       Get.toNamed(Routes.CHOICE_DELIVERY,
    //                                           arguments: [
    //                                             sellerId,
    //                                             packetsJson,
    //                                             indexDelivery
    //                                           ]);
    //                                     },
    //                                     contentPadding: AppStyle.paddingSide12,
    //                                     visualDensity: VisualDensity.compact,
    //                                     dense: true,
    //                                     title: Text(
    //                                         '${'${delivery.services?[index].name}'.toUpperCase()} (${delivery.services?[index].rate.toString().toIdrFormat})',
    //                                         style: text12BlackRegular),
    //                                     subtitle: Text(
    //                                       '${delivery.services?[index].duration}',
    //                                       style: text12HintRegular,
    //                                     ),
    //                                     trailing: Icon(
    //                                       Icons.arrow_forward_ios_rounded,
    //                                       size: 14.wr,
    //                                     ),
    //                                   ),
    //                                 ))))
    //                     .toList(),
    //               ),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
