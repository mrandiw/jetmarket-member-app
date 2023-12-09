import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../utils/network/action_status.dart';

enum AppButtonType {
  primary,
  secondary,
  secondaryGrey,
}

class AppButton extends StatelessWidget {
  const AppButton._({
    Key? key,
    required this.onPressed,
    required this.buttonType,
    required this.actionStatus,
    this.text,
  }) : super(key: key);

  final Function()? onPressed;
  final AppButtonType buttonType;
  final ActionStatus actionStatus;
  final String? text;

  factory AppButton.primary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primary,
        actionStatus: actionStatus,
        text: text,
      );
  factory AppButton.secondary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondary,
        actionStatus: actionStatus,
        text: text,
      );
  factory AppButton.secondaryGrey({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryGrey,
        actionStatus: actionStatus,
        text: text,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 42.h,
      child: ElevatedButton(
        style: _getButtonStyle(),
        onPressed: actionStatus == ActionStatus.loading ? () {} : onPressed,
        child: actionStatus == ActionStatus.loading
            ? _onLoading()
            : _buildButtonContent(),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (buttonType) {
      case AppButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryGrey:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(color: kSofterGrey)),
        );
    }
  }

  Widget _onLoading() {
    return Center(
      child: SizedBox(
        height: 24.r,
        width: 24.r,
        child: const CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildButtonContent() {
    switch (buttonType) {
      case AppButtonType.primary:
        return _textPrimary(text ?? 'Button');

      case AppButtonType.secondary:
        return _textSecondary(text ?? 'Button');

      case AppButtonType.secondaryGrey:
        return _textSecondaryGrey(text ?? 'Button');
    }
  }

  Widget _textPrimary(String text) {
    return Center(child: Text(text, style: text14WhiteSemiBold));
  }

  Widget _textSecondary(String text) {
    return Center(
        child: Text(text,
            style: onPressed == null
                ? text14WhiteSemiBold
                : text14PrimarySemiBold));
  }

  Widget _textSecondaryGrey(String text) {
    return Center(child: Text(text, style: text14HintRegular));
  }
}
