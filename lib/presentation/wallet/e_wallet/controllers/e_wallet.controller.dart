import 'package:get/get.dart';

class EWalletController extends GetxController {
  var isShowEwallet = false.obs;
  List<dynamic> histories = [];

  void onShowSaldo() {
    isShowEwallet.value = !isShowEwallet.value;
  }

  @override
  void onInit() {
    histories = List.generate(
        4,
        (index) => {
              'id': index,
              'title': index == 0
                  ? 'Withdraw Berhasil'
                  : index == 1
                      ? 'Withdraw Ditolak'
                      : index == 2
                          ? 'Menunggu Persetujuan'
                          : 'Withdraw Dibatalkan',
              'subtitle': index == 0
                  ? 'Penarikan dana sevesar Rp1.000.000 telah dikirim ke rekening kamu.'
                  : index == 1
                      ? 'Admin menolak penarikan dana yang kamu ajukan.'
                      : index == 2
                          ? 'Mohon menunggu. Penarikan dana sebesar Rp500.000 menunggu persetujuan admin.'
                          : 'Penarikan dana sebesar Rp2.000.000 dibatalkan oleh kamu.',
              'type': index == 0
                  ? 'success'
                  : index == 1
                      ? 'reject'
                      : index == 2
                          ? 'waiting'
                          : 'cancel'
            });
    super.onInit();
  }
}
