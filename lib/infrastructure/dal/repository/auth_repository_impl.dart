import 'package:dio/dio.dart';
import 'package:jetmarket/domain/core/model/model_data/checking_auth.dart';
import '../../../../domain/core/interfaces/auth_repository.dart';
import '../../../../domain/core/model/model_data/user_model.dart';
import '../../../../domain/core/model/params/auth/forgot_param.dart';
import '../../../../domain/core/model/params/auth/forgot_verify_otp_param.dart';
import '../../../../domain/core/model/params/auth/login_param.dart';
import '../../../../domain/core/model/params/auth/register_param.dart';
import '../../../../domain/core/model/params/auth/register_virify_otp_param.dart';
import '../../../domain/core/model/model_data/user_profile.dart';
import '../../../domain/core/model/params/auth/profile_body.dart';
import '../../../utils/app_preference/app_preferences.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../daos/provider/endpoint/endpoint.dart';
import '../daos/provider/remote/remote_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<DataState<UserModel>> login(LoginParam param) async {
    try {
      final response =
          await RemoteProvider.post(path: Endpoint.login, data: param.toMap());
      await AppPreference().saveAccessToken(
          status: response.statusCode, token: response.data['data']['token']);
      await AppPreference().saveUserData(
        status: response.statusCode,
        data: response.data['data'],
      );

      return DataState<UserModel>(
          status: StatusCodeResponse.cek(response: response),
          result: UserModel.fromJson(response.data['data']));
    } on DioException catch (e) {
      return CustomException<UserModel>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> sendRegisterOtp(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpSend, data: {'email': param});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> verifyRegisterOtp(
      RegisterVerifyOtpParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpVerify, data: param.toMap());
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<String>> verifyForgotOtp(ForgotVerifyOtpParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpVerify, data: param.toMap());

      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data']['token'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<UserModel>> register(RegisterParam param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.register, data: param.toMap());
      if (response.statusCode == 200) {
        AppPreference().saveAccessToken(
            status: 200, token: response.data['data']['token']);
        await AppPreference().saveUserData(
          status: response.statusCode,
          data: response.data['data'],
        );
      } else {}
      return DataState<UserModel>(
        status: StatusCodeResponse.cek(response: response),
        result: UserModel.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<UserModel>().dio(e);
    }
  }

  @override
  Future<bool?> forgot(ForgotParam param) async {
    return false;
  }

  @override
  Future<DataState<bool>> reset(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.reset, data: {"password": param});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> sendOtp(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.otpSend, data: {'email': param, 'role': 'customer'});
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<String>> claimReferral(String param) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.claimReferral, data: {"referral": param});
      String message = response.data['message'];
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: message,
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<bool>> logout() async {
    try {
      final response = await RemoteProvider.post(path: Endpoint.logout);
      return DataState<bool>(
        status: StatusCodeResponse.cek(response: response),
      );
    } on DioException catch (e) {
      return CustomException<bool>().dio(e);
    }
  }

  @override
  Future<DataState<String>> deleteAccount() async {
    try {
      final response =
          await RemoteProvider.delete(path: Endpoint.deleteAccount);
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<UserProfile>> getUserProfile(int id) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.profile}/$id');
      await AppPreference().saveUserProfile(
        status: response.statusCode,
        data: response.data['data'],
      );

      return DataState<UserProfile>(
        status: StatusCodeResponse.cek(response: response),
        result: UserProfile.fromJson(response.data['data']),
      );
    } on DioException catch (e) {
      return CustomException<UserProfile>().dio(e);
    }
  }

  @override
  Future<DataState<String>> uploadFile(
      {required String name, required String image}) async {
    try {
      FormData formData = FormData.fromMap({
        'name': name,
        'images': await MultipartFile.fromFile(image, filename: name),
      });
      final response =
          await RemoteProvider.post(path: Endpoint.fileImage, data: formData);
      return DataState<String>(
        status: StatusCodeResponse.cek(response: response),
        result: response.data['data'][0],
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<String>().dio(e);
    }
  }

  @override
  Future<DataState<UserProfile>> editUserProfile(
      {required int id, required ProfileBody body}) async {
    try {
      // FormData formData = FormData.fromMap({
      //   'name': body.name,
      //   'gender': body.gender,
      //   'birth_date': body.birthDate,
      //   'phone': body.phone,
      //   'email': body.email,
      //   'foto':
      //       await MultipartFile.fromFile(body.image ?? '', filename: 'users'),
      // });
      final response = await RemoteProvider.put(
          path: '${Endpoint.profile}/$id', data: body.toMap());

      return DataState<UserProfile>(
        status: StatusCodeResponse.cek(response: response),
        result: UserProfile.fromJson(response.data['data']),
        message: response.data['message'],
      );
    } on DioException catch (e) {
      return CustomException<UserProfile>().dio(e);
    }
  }

  @override
  Future<DataState<CheckingAuth>> checkingAuth({required int id}) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.profile}/$id');

      return DataState<CheckingAuth>(
          status: StatusCodeResponse.cek(response: response),
          result: CheckingAuth.fromJson(response.data['data']),
          message: response.data['message']);
    } on DioException catch (e) {
      return CustomException<CheckingAuth>().dio(e);
    }
  }
}
