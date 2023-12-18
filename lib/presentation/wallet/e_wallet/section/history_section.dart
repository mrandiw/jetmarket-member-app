import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HistorySection extends StatelessWidget {
  const HistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppStyle.paddingAll16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('All History', style: text14BlackMedium),
          Gap(12.hr),
          Column(
              children: List.generate(
                  10,
                  (index) => Padding(
                      padding: AppStyle.paddingBottom12,
                      child: Container(
                          padding: AppStyle.paddingAll12,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: AppStyle.borderRadius8All,
                              border: AppStyle.borderAll),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(index == 0
                                  ? wdSuccess
                                  : index == 2
                                      ? wdReject
                                      : index == 3
                                          ? wdWaiting
                                          : wdCancel),
                              Gap(12.wr),
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Withdraw Berhasil',
                                          style: text12BlackMedium),
                                      Text('20/11/2023',
                                          style: text8GreyRegular)
                                    ],
                                  ),
                                  Gap(4.hr),
                                  Text(
                                    'Penarikan dana sevesar Rp1.000.000 telah dikirim ke rekening kamu.',
                                    style: text11GreyRegular,
                                  ),
                                  Gap(6.hr),
                                  GestureDetector(
                                      child: Text('Lihat Detail',
                                          style: text11PrimaryRegular))
                                ],
                              ))
                            ],
                          )))))
        ],
      ),
    );
  }
}
