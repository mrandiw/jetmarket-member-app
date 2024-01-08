import '../../../utils/network/data_state.dart';
import '../model/model_data/payment_customer_model.dart';
import '../model/model_data/payment_methode_model.dart';
import '../model/model_data/payment_payletter.dart';
import '../model/model_data/tutorial_payment_va_model.dart';
import '../model/params/auth/payment_param.dart';

abstract class PaymentRepository {
  Future<DataState<PaymentMethodeModel>> getPaymentMethode();
  Future<DataState<PaymentCustomerModel>> createPaymentCustomer(
      PaymentParam param);
  Future<DataState<PaymentCustomerModel>> getPaymentCustomer(int id);
  Future<TutorialPaymentVaModel> fetchDataFromJsonFile(String param);
  Future<DataState<PaymentPayletter>> getPaymentPayletter(int amount);
}
