import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_colors.dart';
import 'package:jetmarket/presentation/koperasi_pages/daftar_pengajuan_pinjaman/controllers/daftar_pengajuan_pinjaman.controller.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../../infrastructure/theme/app_text.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
          padding: AppStyle.paddingAll16,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Lihat berdasarkan', style: text14BlackMedium),
              GetBuilder<DaftarPengajuanPinjamanController>(
                  builder: (controller) {
                return MenuAnchor(
                  controller: controller.menuController,
                  builder: (_, ctrlBuilder, child) {
                    return GestureDetector(
                      onTap: () {
                        if (ctrlBuilder.isOpen) {
                          ctrlBuilder.close();
                        } else {
                          ctrlBuilder.open();
                        }
                      },
                      child: Row(children: [
                        Text('Semua', style: text12BlackMedium),
                        Gap(4.wr),
                        const Icon(Icons.keyboard_arrow_down_rounded)
                      ]),
                    );
                  },
                  menuChildren: List<MenuItemButton>.generate(
                    3,
                    (int index) => MenuItemButton(
                      child: Text(
                        'Item ${index + 1}',
                        style: text12BlackRegular,
                      ),
                      onPressed: () {
                        controller.menuController?.close();
                      },
                    ),
                  ),
                  style: const MenuStyle(
                    // alignment: Alignment.bottomCenter,
                    backgroundColor: MaterialStatePropertyAll(kWhite),
                    surfaceTintColor: MaterialStatePropertyAll(kWhite),
                    elevation: MaterialStatePropertyAll(12),
                    shadowColor: MaterialStatePropertyAll(
                      Color.fromARGB(50, 217, 217, 217),
                    ),
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                  ),
                );
              }),

              // MenuAnchor(
              // style: const MenuStyle(
              //   alignment: Alignment.bottomRight,
              //   elevation: MaterialStatePropertyAll(12),
              //   shadowColor: MaterialStatePropertyAll(
              //     Color.fromARGB(50, 217, 217, 217),
              //   ),
              //   padding: MaterialStatePropertyAll(EdgeInsets.zero),
              // ),
              //     menuChildren: List.generate(
              //         3,
              //         (index) => MenuItemButton(
              //             child: Text('Filter $index',
              //                 style: text12BlackRegular))),
              //     child: Row(
              //       children: [
              //         Text('Semua', style: text12BlackMedium),
              //         Gap(4.wr),
              //         const Icon(Icons.keyboard_arrow_down_rounded)
              //       ],
              //     )
              //     )
            ],
          )),
    );
  }
}
