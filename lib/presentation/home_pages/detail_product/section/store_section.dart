import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/components/button/app_button.dart';
import 'package:jetmarket/presentation/home_pages/detail_product/controllers/detail_product.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';

class StoreSection extends StatelessWidget {
  const StoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailProductController>(builder: (controller) {
      return Padding(
        padding: AppStyle.paddingSide16,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: AppStyle.borderSide, top: AppStyle.borderSide)),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CachedNetworkImage(
                imageUrl: controller.detailProduct?.seller?.avatar ?? '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 26.r,
                      backgroundColor: kPrimaryColor2,
                      backgroundImage: imageProvider,
                    ),
                placeholder: (context, url) => SizedBox(
                      height: 72.r,
                      width: 72.r,
                      child: const Center(
                        child: CupertinoActivityIndicator(color: kSoftBlack),
                      ),
                    ),
                errorWidget: (context, url, error) => CircleAvatar(
                      radius: 26.r,
                      backgroundColor: kPrimaryColor2,
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: kPrimaryColor,
                          size: 20.r,
                        ),
                      ),
                    )),
            title: Text(controller.detailProduct?.seller?.name ?? '',
                style: text14BlackMedium),
            subtitle: Text(controller.detailProduct?.seller?.city ?? '',
                style: text12HintRegular),
            trailing: SizedBox(
                width: 124.wr,
                child: AppButton.primary(
                  text: 'Lihat Toko',
                  onPressed: () => controller
                      .toDetailStore(controller.detailProduct?.seller?.id ?? 0),
                )),
          ),
        ),
      );
    });
  }
}
