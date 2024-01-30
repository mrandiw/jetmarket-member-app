import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/utils/network/data_state.dart';

abstract class EwalletRepository {
  Future<DataState<int>> getWalletBalance();
  Future<DataState<List<BalanceHistoryModel>>> getBalanceHistory(
      {required int page, required int size});
  // Future<DataState<String>> getPaymentMethode();
}
