import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class DetailProduct extends StatelessWidget {
  const DetailProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingSide16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detail Produk', style: text14BlackMedium),
            Gap(12.h),
            Column(
                children: List.generate(2, (index) {
              return Padding(
                padding: AppStyle.paddingBottom8,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: AppStyle.borderRadius8All,
                      side: AppStyle.borderSide),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: AppStyle.borderRadius8All,
                      child: Image.network(
                        'https://plus.unsplash.com/premium_photo-1701083991041-16b72d10d2b7?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                        height: 50.r,
                        width: 50.r,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text('Buku Jurnal', style: text12BlackMedium),
                    subtitle: Text('1 x Rp 20.000', style: text11GreyRegular),
                  ),
                ),
              );
            }))
          ],
        ));
  }
}
