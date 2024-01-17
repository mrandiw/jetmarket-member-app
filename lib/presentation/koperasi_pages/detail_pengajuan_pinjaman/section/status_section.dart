import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_pengajuan_pinjaman/controllers/detail_pengajuan_pinjaman.controller.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

class StatusPengajuanPinjaman extends StatelessWidget {
  const StatusPengajuanPinjaman({super.key, required this.controller});

  final DetailPengajuanPinjamanController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppStyle.paddingAll12,
      width: Get.width.wr,
      decoration: const BoxDecoration(
          color: Color(0xffEEF0F8),
          border: Border(left: BorderSide(color: Color(0xffCACDE4), width: 2))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(canceled),
          Gap(8.wr),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.detailLoan?.note?.title ?? '',
                  style: text12BlackMedium),
              Gap(4.hr),
              Text(controller.detailLoan?.note?.description ?? '',
                  style: text12BlackRegular),
            ],
          )
        ],
      ),
    );
  }
}
