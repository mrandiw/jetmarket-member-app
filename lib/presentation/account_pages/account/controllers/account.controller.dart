import 'dart:developer';

import 'package:get/get.dart';
import 'package:jetmarket/components/dialog/app_dialog_confirmation.dart';
import 'package:jetmarket/domain/core/interfaces/auth_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/user_model.dart';
import 'package:jetmarket/infrastructure/navigation/routes.dart';
import 'package:jetmarket/presentation/main_pages/controllers/main_pages.controller.dart';
import 'package:jetmarket/utils/app_preference/app_preferences.dart';
import 'package:jetmarket/utils/network/status_response.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../domain/core/model/model_data/user_profile.dart';
import '../../../../utils/network/action_status.dart';

class AccountController extends GetxController {
  final AuthRepository _authRepository;
  AccountController(this._authRepository);

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var actionStatus = ActionStatus.initalize.obs;
  UserProfile? userData;

  Future<void> getProfile(int id, bool isRefresh) async {
    final response = await _authRepository.getUserProfile(id);
    if (response.status == StatusResponse.success) {
      userData = response.result;
      log("USERNYA : ${userData?.toJson().toString()}");
      update();
      updateEmploye(isRefresh);
    }
  }

  void updateEmploye(bool isRefresh) {
    final mainController = Get.put(MainPagesController());
    if (isRefresh) {
      if (userData?.isEmployee != mainController.isEmployees) {
        AppPreference().clearOnLogout();
        Future.delayed(1.seconds, () {
          Get.offAllNamed(Routes.LOGIN);
        });
      }
    }
  }

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

  setDataUser(bool isRefresh) {
    UserModel? userData = AppPreference().getUserData();
    getProfile(userData?.user?.id ?? 0, isRefresh);
  }

  void onRefresh() async {
    await Future.delayed(1.seconds, () {
      setDataUser(true);
    });
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(1.seconds);
    if (isClosed) refreshController.loadComplete();
  }

  @override
  void onInit() {
    setDataUser(false);
    super.onInit();
  }
}
