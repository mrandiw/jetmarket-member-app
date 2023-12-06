import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class ListAddressSection extends StatelessWidget {
  const ListAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingSide16,
        child: Column(
            children: List.generate(
                4,
                (index) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius8All,
                            side: AppStyle.borderSide),
                        color: kWhite,
                        child: Padding(
                          padding: AppStyle.paddingAll12,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text('Rumah',
                                              style: text12BlackRegular),
                                          Gap(8.w),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 4.h),
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor2,
                                                  borderRadius: AppStyle
                                                      .borderRadius6All),
                                              child: Text('Utama',
                                                  style: text12PrimaryRegular)),
                                        ],
                                      ),
                                      Text('John Doe',
                                          style: text12BlackRegular),
                                      Gap(4.h),
                                      Text('(+62) 4789096367',
                                          style: text12HintRegular),
                                      Gap(4.h),
                                      Text(
                                          '2118 Thornridge Cir. Syracuse, Connecticut 35624',
                                          style: text12HintRegular),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {},
                                        child: Text(
                                          'Ubah',
                                          style: text11NormalMedium,
                                        )),
                                    Gap(8.h),
                                    SizedBox(
                                      width: 8.r,
                                      height: 8.r,
                                      child: Transform.scale(
                                        scale: 0.7,
                                        child: RadioListTile(
                                            activeColor: kPrimaryColor,
                                            value: index,
                                            selected: 0 == index,
                                            groupValue: 99,
                                            onChanged: (value) {}),
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                        ))))));
  }
}
