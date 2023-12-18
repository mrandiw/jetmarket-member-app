import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/presentation/home_pages/home/controllers/home.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/form/app_form_icon.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../utils/assets/assets_svg.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key, required this.controller});
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Padding(
      padding: AppStyle.paddingAll16,
      child: Row(
        children: [
          Expanded(
            child: AppFormIcon(
              controller: controller.searchController,
              icon: search,
              hintText: 'Cari produk',
              onChanged: (value) => controller.searchProducts(value),
            ),
          ),
          Gap(10.wr),
          GestureDetector(
            onTap: () => controller.openFilter(),
            child: Container(
              height: 42.r,
              width: 42.r,
              decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  border: AppStyle.borderAll),
              child: Center(
                child: SvgPicture.asset(miFilter),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
