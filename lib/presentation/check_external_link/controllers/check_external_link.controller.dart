import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../domain/core/interfaces/auth_repository.dart';
import '../../../domain/core/model/argument/payment_methode_argument.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../utils/app_preference/app_preferences.dart';
import '../../../utils/network/status_response.dart';

class CheckExternalLinkController extends GetxController {
  final AuthRepository _authRepository;

  CheckExternalLinkController(this._authRepository);
  Future<void> checkingAuth() async {
    bool isTokenReady = AppPreference().getAccessToken() != null;
    int? userId = AppPreference().getUserData()?.user?.id;
    int? trxid = AppPreference().getTrxId();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (isTokenReady) {
        final response = await _authRepository.checkingAuth(id: userId ?? 0);
        if (response.status == StatusResponse.success) {
          if (trxid == null) {
            if (response.result?.activatedAt != null &&
                response.result?.isVerified == true) {
              Get.offAllNamed(Routes.MAIN_PAGES);
            } else if (response.result?.isVerified == false) {
              Get.offAllNamed(Routes.REGISTER_OTP);
            } else if (response.result?.isVerified == true) {
              Get.offAllNamed(Routes.SUCCESS_VERIFY_OTP);
            } else {
              Get.offAllNamed(Routes.LOGIN);
            }
          } else {
            var argument = PaymentMethodeArgument(
                trxId: AppPreference().getTrxId(), status: "waiting");
            Get.offAllNamed(Routes.DETAIL_PAYMENT_REGISTER,
                arguments: argument);
          }
        } else {
          Get.offAllNamed(Routes.LOGIN);
        }
      } else {
        Get.offAllNamed(Routes.LOGIN);
      }
    });
  }
}
