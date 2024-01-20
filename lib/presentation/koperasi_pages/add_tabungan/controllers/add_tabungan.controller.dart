import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jetmarket/components/snackbar/app_snackbar.dart';
import 'package:jetmarket/utils/extension/remove_comma.dart';
import 'package:jetmarket/utils/network/action_status.dart';

import '../../../../components/bottom_sheet/show_bottom_sheet.dart';
import '../../../../components/snackbar/app_snackbar_black.dart';
import '../../../../domain/core/interfaces/saving_repository.dart';
import '../../../../domain/core/model/params/saving/saving_installment_param.dart';
import '../../../../utils/network/status_response.dart';
import '../widget/picker_date.dart';

class AddTabunganController extends GetxController {
  final SavingRepository _savingRepository;

  AddTabunganController(this._savingRepository);

  TextEditingController nominalController = TextEditingController();

  var selectedDatePicker = "";
  var selectedDateOnlyPicker = "";
  bool isNominalValue = false;
  var actionStatus = ActionStatus.initalize;

  var datePicker = <DateTime?>[];

  pickDate(List<DateTime?> date) {
    datePicker = date;
    selectedDateOnlyPicker = DateFormat('dd').format(date[0]!);
    selectedDatePicker = DateFormat('yyyy-MM-dd').format(date[0]!);
    update();
  }

  void listenNominalForm(String value) {
    if (value.isNotEmpty) {
      isNominalValue = true;
      update();
    } else {
      isNominalValue = false;
      update();
    }
  }

  Future<void> saveSaving() async {
    actionStatus = ActionStatus.loading;
    update();
    var param = SavingInstallmentParam(
        dueAt: selectedDatePicker,
        amount: int.parse(nominalController.text.removeComma));
    final response = await _savingRepository.savingInstallment(param);
    if (response.status == StatusResponse.success) {
      actionStatus = ActionStatus.success;
      Get.back();
      AppSnackbarBlack.show('Tabungan terjadwal berhasil dibuat');
    } else {
      actionStatus = ActionStatus.failed;
      update();
      AppSnackbar.show(message: response.message, type: SnackType.error);
    }
  }

  void openCalendarView() {
    CustomBottomSheet.show(child: PickerDate(controller: this));
  }
}
