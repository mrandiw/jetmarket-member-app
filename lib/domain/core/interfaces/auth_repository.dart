import 'package:jetmarket/domain/core/model/params/auth/register_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/payment_customer_model.dart';
import '../model/model_data/payment_methode_model.dart';
import '../model/model_data/tutorial_payment_va_model.dart';
import '../model/params/auth/forgot_param.dart';
import '../model/params/auth/forgot_verify_otp_param.dart';
import '../model/params/auth/login_param.dart';
import '../model/params/auth/payment_param.dart';
import '../model/params/auth/register_virify_otp_param.dart';
import '../model/params/auth/reset_param.dart';

abstract class AuthRepository {
  Future<DataState<bool>> login(LoginParam param);
  Future<DataState<bool>> register(RegisterParam param);
  Future<DataState<bool>> sendRegisterOtp(String param);
  Future<DataState<bool>> verifyRegisterOtp(RegisterVerifyOtpParam param);
  Future<DataState<bool>> verifyForgotOtp(ForgotVerifyOtpParam param);
  Future<bool?> forgot(ForgotParam param);
  Future<DataState<bool>> reset(ResetParam param);
  Future<DataState<bool>> sendOtp(String param);
  Future<DataState<PaymentMethodeModel>> getPaymentMethode();
  Future<DataState<PaymentCustomerModel>> createPaymentCustomer(
      PaymentParam param);
  Future<TutorialPaymentVaModel> fetchDataFromJsonFile(String param);
}
