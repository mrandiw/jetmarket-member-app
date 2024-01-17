import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/loan_propose_model.dart';
import 'package:jetmarket/presentation/koperasi_pages/daftar_pengajuan_pinjaman/controllers/daftar_pengajuan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';
import '../../../../infrastructure/navigation/routes.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/assets/assets_svg.dart';
import '../widget/loan_item.dart';

class ListPengajuan extends StatelessWidget {
  const ListPengajuan({super.key, required this.controller});

  final DaftarPengajuanPinjamanController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppStyle.paddingAll16,
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<LoanProposeModel>(
              itemBuilder: (context, item, index) => LoanItem(
                data: item,
              ),
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Pinjaman'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
