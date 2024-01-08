import 'package:jetmarket/domain/core/model/params/auth/register_param.dart';

import '../../../utils/network/data_state.dart';
import '../model/model_data/user_model.dart';
import '../model/model_data/user_profile.dart';
import '../model/params/auth/forgot_param.dart';
import '../model/params/auth/forgot_verify_otp_param.dart';
import '../model/params/auth/login_param.dart';
import '../model/params/auth/profile_body.dart';
import '../model/params/auth/register_virify_otp_param.dart';

abstract class AuthRepository {
  Future<DataState<UserModel>> login(LoginParam param);
  Future<DataState<UserModel>> register(RegisterParam param);
  Future<DataState<bool>> sendRegisterOtp(String param);
  Future<DataState<bool>> verifyRegisterOtp(RegisterVerifyOtpParam param);
  Future<DataState<String>> verifyForgotOtp(ForgotVerifyOtpParam param);
  Future<bool?> forgot(ForgotParam param);
  Future<DataState<bool>> reset(String param);
  Future<DataState<bool>> sendOtp(String param);

  Future<DataState<String>> claimReferral(String param);
  Future<DataState<bool>> logout();
  Future<DataState<String>> deleteAccount();
  Future<DataState<UserProfile>> getUserProfile(int id);
  Future<DataState<String>> uploadFile(
      {required String name, required String image});
  Future<DataState<UserProfile>> editUserProfile(
      {required int id, required ProfileBody body});
}
