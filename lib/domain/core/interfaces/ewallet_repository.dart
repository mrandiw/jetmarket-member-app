import 'package:jetmarket/domain/core/model/model_data/balance_history_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_withdraw_model.dart';
import 'package:jetmarket/domain/core/model/params/wallet/wallet_withdraw_body.dart';
import 'package:jetmarket/utils/network/data_state.dart';

import '../model/model_data/detail_topup_model.dart';
import '../model/model_data/waiting_payment_model.dart';
import '../model/params/wallet/send_withdraw_body.dart';
import '../model/params/wallet/wallet_topup_body.dart';

abstract class EwalletRepository {
  Future<DataState<int>> getWalletBalance();
  Future<DataState<List<BalanceHistoryModel>>> getBalanceHistory(
      {required int page, required int size});
  Future<DataState<List<String>>> getPaymentMethode();
  Future<DataState<bool>> walletWithdraw(EwalletWithdrawBody body);
  Future<DataState<DetailWithdrawModel>> getDetailWithdraw(
      {required String id});
  Future<DataState<DetailTopupModel>> getDetailTopup({required String id});
  Future<DataState<String>> topUpWallet(WalletTopupBody body);
  Future<DataState<WaitingPaymentModel>> getTransaction(String id);
  Future<DataState<String>> sendWidthdraw(SendWithdrawBody body);
  Future<DataState<bool>> cancelWithdraw(String id);
}
