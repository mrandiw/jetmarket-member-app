import 'package:jetmarket/domain/core/model/model_data/bill_paylater_model.dart';
import 'package:jetmarket/domain/core/model/model_data/detail_paylater_model.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/detail_bill_paylater.dart';
import '../model/model_data/detail_payment_paylater.dart';
import '../model/params/paylater/bill_paylater_body.dart';

abstract class PayLaterRepository {
  Future<DataState<DetailPaylaterModel>> getDetailPaylater();
  Future<DataState<List<BillPaylaterModel>>> getBillPaylater(
      {required int page, required int size});
  Future<DataState<DetailBillPaylater>> getDetailBillPaylater(String refId);
  Future<DataState<DetailPaymentPaylater>> paylaterPay(BillPaylaterBody body);
}
