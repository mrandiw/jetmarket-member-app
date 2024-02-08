import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/assets/assets_svg.dart';

class PinjamanController extends GetxController {
  List<dynamic> choiceLoan = [
    {
      "title": "Ajukan Pinjaman",
      "icon": globalLoan,
    },
    {
      "title": "Daftar Pengajuan",
      "icon": todoList,
    },
    {
      "title": "Tagihan Bulanan",
      "icon": billList,
    }
  ];

  void actionChoice(int index) {
    switch (index) {
      case 0:
        Get.toNamed(Routes.AJUKAN_PINJAMAN);
      case 1:
        Get.toNamed(Routes.DAFTAR_PENGAJUAN_PINJAMAN);
      case 2:
        Get.toNamed(Routes.TAGIHAN_BULANAN_PINJAMAN);
    }
  }
}
