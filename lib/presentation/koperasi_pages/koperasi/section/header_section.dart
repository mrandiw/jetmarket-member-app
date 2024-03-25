import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';

import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/controllers/koperasi.controller.dart';
import 'package:jetmarket/presentation/koperasi_pages/koperasi/widget/menu_icon.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../components/button/app_button.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, required this.controller});
  final KoperasiController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: AppStyle.paddingAll16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<KoperasiController>(builder: (controller) {
                return Container(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Total Tabungan',
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
                                    ? '${controller.savingTotal ?? 0}'
                                        .toIdrFormat
                                    : '********',
                                style: text24WhiteSemiBold,
                              );
                            }),
                          ],
                        ),
                      ),
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
                );
              }),
              Gap(16.hr),
              Row(children: [
                Expanded(
                    child: MenuIcon(
                  title: 'Tabungan',
                  icon: tabunganLine,
                  onTap: () => Get.toNamed(Routes.TABUNGAN_PAYMENT),
                )),
                Gap(12.wr),
                Expanded(
                    child: MenuIcon(
                  title: 'Pinjaman',
                  icon: pinjamanLine,
                  onTap: () => Get.toNamed(Routes.PINJAMAN),
                )),
              ]),
              Gap(16.hr),
              Container(
                padding: AppStyle.paddingAll12,
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: AppStyle.borderRadius8All,
                  boxShadow: [AppStyle.boxShadow],
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Jumlah yang perlu dibayar bulan ini',
                          style: text10HintRegular),
                      Row(
                        children: [
                          Text(
                              '${controller.loanBillCheck?.amount}'.toIdrFormat,
                              style: text14BlackSemiBold),
                          const Spacer(),
                          AppButton.primarySmall(
                            text: 'Bayar',
                            onPressed: controller.loanBillCheck?.amount != null
                                ? () => controller.choicePayment()
                                : null,
                          )
                        ],
                      ),
                      Visibility(
                        visible: controller.loanBillCheck?.dueAt != null,
                        child: Text(
                            'Batas pembayaran ${"${controller.loanBillCheck?.dueAt}".convertToDateFormat}',
                            style: text10ErrorMedium),
                      )
                    ]),
              ),
              Gap(16.hr),
              Text('Riwayat Tabungan', style: text14BlackMedium),
              Gap(12.hr),
            ],
          )),
    );
  }
}
