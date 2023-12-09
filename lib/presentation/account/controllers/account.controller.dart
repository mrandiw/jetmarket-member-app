import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/network/status_response.dart';

import '../../../utils/network/action_status.dart';

class AccountController extends GetxController {
  final AuthRepository _authRepository;
  AccountController(this._authRepository);

  var actionStatus = ActionStatus.initalize.obs;
  UserModel? userData;

  Future<void> logout() async {
    Get.back();
    actionStatus(ActionStatus.loading);
    final response = await _authRepository.logout();
    if (response.status == StatusResponse.success) {
      actionStatus(ActionStatus.success);
      AppPreference().clearOnLogout();
      Future.delayed(1.seconds, () {
        Get.offAllNamed(Routes.LOGIN);
      });
    } else {
      actionStatus(ActionStatus.failed);
    }
  }

  void confirmationLogout() {
    AppDialogConfirmation.show(
      title: 'Logout',
      message: 'Yakin ingin keluar dari akunmu?',
      onTesText: 'keluar',
      onPressed: () => logout(),
    );
  }

  setDataUser() {
    userData = AppPreference().getUserData();
  }

  @override
  void onInit() {
    setDataUser();
    super.onInit();
  }
}
