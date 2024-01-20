import 'package:jetmarket/domain/core/model/model_data/saving_direct_model.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_history_model.dart';
import 'package:jetmarket/domain/core/model/model_data/saving_payment_methode_model.dart';
import 'package:jetmarket/domain/core/model/model_data/waiting_payment_model.dart';
import 'package:jetmarket/domain/core/model/params/saving/saving_direct_param.dart';
import 'package:jetmarket/domain/core/model/params/saving/saving_installment_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/detail_saving_model.dart';

abstract class SavingRepository {
  Future<DataState<DetailSavingModel>> getDetailSaving(int id);
  Future<DataState<int>> getTotalSaving();
  Future<DataState<List<SavingHistoryModel>>> getSavingHistory(
      {required int page, required int size});
  Future<DataState<SavingPaymentMethodeModel>> getSavingPaymentMethode();
  Future<DataState<String>> savingInstallment(SavingInstallmentParam param);
  Future<DataState<SavingDirectModel>> savingDirect(SavingDirectParam param);
  Future<DataState<WaitingPaymentModel?>> waitingPayment();
}
