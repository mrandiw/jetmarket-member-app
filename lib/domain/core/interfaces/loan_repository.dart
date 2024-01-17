import 'package:jetmarket/domain/core/model/model_data/loan_entry_cancel_model.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_entry_param.dart';
import 'package:jetmarket/domain/core/model/params/loan/loan_propose_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/loan_propose_model.dart';
import '../model/params/loan/loan_propose_list_param.dart';

abstract class LoanRepository {
  Future<DataState<int>> loanEntryId(LoanEntryParam param);
  Future<DataState<DetailLoanModel>> loanCancel(int id);
  Future<DataState<int>> loanPropose(LoanProposeParam param);
  Future<DataState<List<LoanProposeModel>>> getLoanPropose(
      LoanProposeListParam param);
  Future<DataState<DetailLoanModel>> getDetailLoanPropose(int id);
}
