import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/model/model_data/address_model.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/controllers/edit_address.controller.dart';
import 'package:jetmarket/presentation/home_pages/edit_address/widget/address_item.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/infiniti_page/infiniti_page.dart';

class ListAddressSection extends StatelessWidget {
  const ListAddressSection({super.key, required this.controller});
  final EditAddressController controller;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: AppStyle.paddingAll16,
        sliver: PagedSliverList.separated(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<AddressModel>(
              itemBuilder: (context, item, index) => AddressItem(
                index: index,
                data: item,
              ),
              newPageProgressIndicatorBuilder: InfinitiPage.progress,
              firstPageProgressIndicatorBuilder: InfinitiPage.progress,
              noItemsFoundIndicatorBuilder: (_) =>
                  InfinitiPage.empty(_, 'Alamat'),
              firstPageErrorIndicatorBuilder: InfinitiPage.error,
            ),
            separatorBuilder: (_, i) => Gap(12.h)));
  }
}
