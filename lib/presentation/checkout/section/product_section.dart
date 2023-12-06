import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../infrastructure/theme/app_text.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingSide16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(12.h),
          Text('Produk Yang Dibeli', style: text14BlackMedium),
          Gap(12.h),
          Row(
            children: [
              ClipRRect(
                borderRadius: AppStyle.borderRadius8All,
                child: Image.network(
                  'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                  height: 64.h,
                  width: 77.w,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(8.h),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pensil Warna 2in1 12 Pcs', style: text12BlackRegular),
                    Text('43000'.toIdrFormat, style: text10lineThroughRegular),
                    Gap(6.h),
                    Text('13000'.toIdrFormat, style: text12PrimaryMedium),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: AppStyle.borderRadius6All,
                      color: kWhite,
                      border: AppStyle.borderAll),
                  child: const Center(
                      child: Icon(
                    Icons.remove,
                    color: kSofterGrey,
                  )),
                ),
              ),
              Gap(12.w),
              Text("1", style: text12BlackRegular),
              Gap(12.w),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: AppStyle.borderRadius6All,
                      color: kWhite,
                      border: AppStyle.borderAll),
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    color: kSofterGrey,
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
