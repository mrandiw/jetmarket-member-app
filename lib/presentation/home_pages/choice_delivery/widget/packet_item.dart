import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/presentation/home_pages/choice_delivery/controllers/choice_delivery.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import '../../../../domain/core/model/model_data/select_delivery.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/style/app_style.dart';

class PacketItem extends StatelessWidget {
  const PacketItem(
      {super.key, required this.index, required this.data, this.onTap});

  final int index;
  final Packets data;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChoiceDeliveryController>(builder: (controller) {
      return Card(
        elevation: 0,
        margin: AppStyle.paddingBottom8,
        color: kWhite,
        shape: RoundedRectangleBorder(
            borderRadius: AppStyle.borderRadius8All, side: AppStyle.borderSide),
        child: ListTile(
          onTap: onTap,
          contentPadding: AppStyle.paddingSide12,
          title: Text("${data.name} (${data.rate.toString().toIdrFormat})",
              style: text12BlackRegular),
          subtitle: Text(
            '${data.duration}',
            style: text12HintRegular,
          ),
          trailing: SizedBox(
            width: 26.w,
            child: RadioListTile(
                activeColor: kPrimaryColor,
                fillColor: MaterialStateProperty.all(
                    controller.selectedPacket == index
                        ? kPrimaryColor
                        : kDivider),
                value: index,
                selected: controller.selectedPacket == index,
                groupValue: controller.selectedPacket,
                onChanged: (value) => controller.selectPacket(value!)),
          ),
        ),
      );
    });
  }
}
