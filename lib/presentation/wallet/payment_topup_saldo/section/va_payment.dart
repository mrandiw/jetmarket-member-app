import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/payment_topup_saldo/controllers/payment_topup_saldo.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class VaPayment extends StatelessWidget {
  const VaPayment({super.key, required this.controller});
  final PaymentTopupSaldoController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bank Mandiri', style: text14BlackMedium),
            Image.asset(
              'assets/images/MANDIRI.png',
              height: 22.h,
              fit: BoxFit.fitHeight,
            )
          ],
        ),
        Gap(12.h),
        Container(
          padding: AppStyle.paddingAll16,
          decoration: BoxDecoration(
              borderRadius: AppStyle.borderRadius8All,
              border: AppStyle.borderAll,
              color: kBorder),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('Nomor Rekening', style: text14HintRegular),
            Gap(8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '8930 8953 5418 7777',
                  style: text18PrimaryBold,
                ),
                Gap(4.w),
                GestureDetector(
                  onTap: () => controller.copyVa(''),
                  child: SvgPicture.asset(
                    copy,
                    colorFilter:
                        const ColorFilter.mode(kNormalColor, BlendMode.srcIn),
                  ),
                )
              ],
            )
          ]),
        ),
        Gap(16.h)
      ],
    );
  }
}
