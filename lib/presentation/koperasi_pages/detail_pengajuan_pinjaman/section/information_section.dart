import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/presentation/koperasi_pages/detail_pengajuan_pinjaman/controllers/detail_pengajuan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/currency.dart';
import 'package:jetmarket/utils/extension/date_format.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

class InformationSection extends StatelessWidget {
  const InformationSection({super.key, required this.controller});

  final DetailPengajuanPinjamanController controller;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Gap(16.hr),
      Text('Informasi Anggota', style: text14BlackMedium),
      Gap(12.hr),
      Text('Nama Lengkap', style: text12HintRegular),
      Gap(4.hr),
      Text(controller.detailLoan?.member?.name ?? '',
          style: text12BlackRegular),
      Gap(12.hr),
      Text('Alamat', style: text12HintRegular),
      Gap(4.hr),
      Text(controller.detailLoan?.member?.address ?? '',
          style: text12BlackRegular),
      Gap(12.hr),
      Text('No. KTP', style: text12HintRegular),
      Gap(4.hr),
      Text(controller.detailLoan?.member?.ktpNumber ?? '',
          style: text12BlackRegular),
      //

      Gap(16.hr),
      Text('Informasi Pinjaman', style: text14BlackMedium),
      Gap(12.hr),
      Text('Tanggal Pengajuan', style: text12HintRegular),
      Gap(4.hr),
      Text(controller.detailLoan?.loan?.createdAt?.formatDate ?? '',
          style: text12BlackRegular),
      Gap(12.hr),
      Text('Nominal Pinjaman', style: text12HintRegular),
      Gap(4.hr),
      Text("${controller.detailLoan?.loan?.amount}".toIdrFormat,
          style: text12BlackRegular),
    ]);
  }
}
