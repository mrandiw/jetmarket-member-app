import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/wallet/e_wallet/controllers/e_wallet.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/navigation/routes.dart';
import '../widget/menu_icon.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.controller});
  final EWalletController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total saldo',
                          style: text18WhiteSemiBold,
                        ),
                        Gap(4.wr),
                        Obx(() {
                          return IconButton(
                              onPressed: () => controller.onShowSaldo(),
                              icon: Icon(
                                controller.isShowEwallet.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: kWhite,
                                size: 18.r,
                              ));
                        })
                      ],
                    ),
                    Obx(() {
                      return Text(
                        controller.isShowEwallet.value
                            ? '${controller.balance.value}'.toIdrFormat
                            : '********',
                        style: text24WhiteSemiBold,
                      );
                    }),
                  ],
                ),
              ),
              Gap(16.hr),
              Row(children: [
                Expanded(
                    child: MenuIcon(
                  title: 'TopUp',
                  icon: Icons.add,
                  onTap: () => controller.openFormTopUp(),
                )),
                Gap(12.wr),
                Expanded(
                    child: MenuIcon(
                        title: 'Withdraw',
                        icon: Icons.arrow_downward,
                        onTap: () => Get.toNamed(Routes.WITHDRAW,
                            arguments: [controller.balance.value]))),
              ]),
              Gap(16.hr),
              Text(
                'History',
                style: text14BlackMedium,
              )
            ],
          )),
    );
  }
}
