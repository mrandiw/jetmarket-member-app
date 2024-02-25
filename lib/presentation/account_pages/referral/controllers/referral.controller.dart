import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jetmarket/domain/core/interfaces/refferal_repository.dart';
import 'package:jetmarket/domain/core/model/model_data/refferal_model.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../infrastructure/dal/services/firebase/deeplink_service.dart';
import '../../../../infrastructure/theme/app_colors.dart';
import '../../../../infrastructure/theme/app_text.dart';
import '../../../../utils/app_preference/app_preferences.dart';

class ReferralController extends GetxController {
  final RefferalRepository _refferalRepository;

  ReferralController(this._refferalRepository);

  PagingController<int, RefferalModel> pagingController =
      PagingController(firstPageKey: 1);

  static const _pageSize = 10;
  String? codeRefferal;

  Future<void> getListRefferal(int pageKey) async {
    try {
      final response = await _refferalRepository.getRefferal(
        page: pageKey,
        size: _pageSize,
      );

      final isLastPage = response.result!.length < _pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(response.result ?? []);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(response.result ?? [], nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void copyVa(String value) {
    Clipboard.setData(ClipboardData(text: value));
    HapticFeedback.vibrate();
    Get.showSnackbar(GetSnackBar(
      margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 88.h),
      backgroundColor: kBlack,
      duration: 2.seconds,
      borderRadius: 8.r,
      messageText: Text(
        'Kode referral berhasil disalin',
        style: text12WhiteRegular,
        textAlign: TextAlign.center,
      ),
    ));
  }

  void shareReferral() async {
    final String deeplink = await DeeplinkService.createLink(
        code: codeRefferal ?? '', type: DeeplinkType.register);
    await Share.share(deeplink, subject: 'Look what I made!');
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      getListRefferal(page);
    });
    codeRefferal = AppPreference().getUserData()?.user?.referral ?? '';
    super.onInit();
  }
}
