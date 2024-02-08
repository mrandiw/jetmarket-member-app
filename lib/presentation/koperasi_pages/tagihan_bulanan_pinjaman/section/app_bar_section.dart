import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

class AppBarTagihanBulanan extends StatelessWidget {
  const AppBarTagihanBulanan({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      backgroundColor: kWhite,
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () => Get.back(),
        icon: SvgPicture.asset(arrowForward),
      ),
      title: Text('Tagihan Bulanan', style: text16BlackSemiBold),
    );
  }
}
