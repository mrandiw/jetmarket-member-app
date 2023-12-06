import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/utils/extension/currency.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';
import '../../../utils/style/app_style.dart';
import '../controllers/order.controller.dart';

class DoneOrder extends StatelessWidget {
  const DoneOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Column(
          children: List.generate(2, (index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16.w, index == 0 ? 16.h : 0, 16.w, 8.h),
          child: GestureDetector(
            onTap: () => controller.toDetailOrder('done'),
            child: Card(
              elevation: 0,
              margin: EdgeInsets.zero,
              shadowColor: const Color(0xffE0E0EC).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                  borderRadius: AppStyle.borderRadius8All,
                  side: AppStyle.borderSide),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: AppStyle.paddingAll12,
                      child: Text('Selesai', style: text12SucessRegular)),
                  Divider(height: 0, thickness: 1, color: kBorder),
                  Padding(
                    padding: AppStyle.paddingAll12,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: AppStyle.borderRadius8All,
                          child: Image.network(
                            'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                            height: 50.r,
                            width: 50.r,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Gap(8.h),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pensil Warna 2in1 12 Pcs',
                                  style: text14BlackSemiBold),
                              Gap(6.h),
                              Row(
                                children: [
                                  Text('43000'.toIdrFormat,
                                      style: text14BlackRegular),
                                  Gap(8.w),
                                  Text('50000',
                                      style: text14lineThroughRegular),
                                ],
                              ),
                            ])
                      ],
                    ),
                  ),
                  Center(
                      child: Text(
                    'Lihat 1 produk lainnya',
                    style: text12HintRegular,
                  )),
                  Gap(12.h),
                  Divider(height: 0, thickness: 1, color: kBorder),
                  Padding(
                    padding: AppStyle.paddingAll12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total bayar', style: text12BlackRegular),
                            Text('43000'.toIdrFormat,
                                style: text12PrimaryMedium)
                          ],
                        ),
                        AppButton.primary(
                          text: 'Review',
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }));
    });
  }
}
