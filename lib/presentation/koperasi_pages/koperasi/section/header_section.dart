import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/controllers/koperasi.controller.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/widget/menu_icon.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.controller});
  final KoperasiController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: AppStyle.paddingAll16,
        child: Column(
          children: [
            Container(
              padding: AppStyle.paddingAll12,
              decoration: BoxDecoration(
                  borderRadius: AppStyle.borderRadius8All,
                  boxShadow: [AppStyle.boxShadow],
                  gradient: const LinearGradient(
                      colors: [kPrimaryColor, Color(0xffE98F8B)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter)),
              child: Row(
                children: [
                  Expanded(
                      flex: 7,
                      child: Text(
                        'Bersama Koperasi Lebih Baik.',
                        style: text18WhiteSemiBold,
                      )),
                  Expanded(
                      flex: 3,
                      child: SvgPicture.asset(
                        koperasiFill,
                        height: 64.hr,
                        fit: BoxFit.fitHeight,
                        colorFilter:
                            const ColorFilter.mode(kWhite, BlendMode.srcIn),
                      ))
                ],
              ),
            ),
            Gap(16.hr),
            Row(children: [
              const Expanded(
                  child: MenuIcon(title: 'Tabungan', icon: tabunganLine)),
              Gap(12.wr),
              const Expanded(
                  child: MenuIcon(title: 'Pinjaman', icon: pinjamanLine)),
            ]),
          ],
        ));
  }
}
