import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import '../../../../domain/core/model/model_data/set_refund_model.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class DeliveryItem extends StatelessWidget {
  const DeliveryItem({super.key, required this.data});

  final List<Services>? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Get.width.wr,
          child: Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                highlightColor: kWhite,
                hoverColor: kWhite,
                focusColor: kWhite,
                splashColor: kWhite),
            child: ExpansionTile(
              title: Text(
                'Pengiriman',
                style: text12BlackSemiBold,
              ),
              iconColor: kBlack,
              tilePadding: EdgeInsets.zero,
              initiallyExpanded: true,
              children: [
                Container(
                  width: Get.width.wr,
                  padding: AppStyle.paddingAll8,
                  decoration: BoxDecoration(
                    color: kBorder,
                    borderRadius: AppStyle.borderRadius8All,
                  ),
                  child: Column(
                      children: List.generate(
                          data?.length ?? 0,
                          (index) => Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: AppStyle.borderRadius8All,
                                ),
                                color: kWhite,
                                child: ListTile(
                                  onTap: () {
                                    List<dynamic>? packets =
                                        data?[index].packets;
                                    String packetsJson = jsonEncode(packets);
                                    Get.toNamed(Routes.CHOICE_DELIVERY_REFUND,
                                        arguments: [index, packetsJson]);
                                  },
                                  contentPadding: AppStyle.paddingSide12,
                                  visualDensity: VisualDensity.compact,
                                  dense: true,
                                  title: Text(
                                      '${'${data?[index].name}'.toUpperCase()} (${data?[index].rate.toString().toIdrFormat})',
                                      style: text12BlackRegular),
                                  subtitle: Text(
                                    '${data?[index].duration}',
                                    style: text12HintRegular,
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14.wr,
                                  ),
                                ),
                              ))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
