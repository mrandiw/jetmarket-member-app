import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
          children: List.generate(
              3,
              (index) => Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Card(
                      color: kWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppStyle.borderRadius8All,
                      ),
                      shadowColor: const Color(0xffE0E0EC).withOpacity(0.2),
                      elevation: 4,
                      child: ListTile(
                          tileColor: kWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppStyle.borderRadius8All,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 6.h),
                          title: Text(
                            'Selamat! Kamu mendapatkan Rp10.000',
                            style: text12BlackMedium,
                          ),
                          subtitle: Text(
                            'Kar***n telah bergabung menggunakan kode refferalmu.',
                            style: text12HintRegular,
                          )),
                    ),
                  ))),
    );
  }
}
