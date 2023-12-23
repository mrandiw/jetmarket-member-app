import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../utils/network/action_status.dart';

enum AppButtonType {
  primary,
  secondary,
  secondaryGrey,
  primaryIcon,
  secondaryIcon,
  secondaryIconFix,
}

class AppButton extends StatelessWidget {
  const AppButton._({
    Key? key,
    required this.onPressed,
    required this.buttonType,
    required this.actionStatus,
    this.text,
    this.icon,
  }) : super(key: key);

  final Function()? onPressed;
  final AppButtonType buttonType;
  final ActionStatus actionStatus;
  final String? text;
  final String? icon;

  factory AppButton.primary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primary,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondary,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryGrey({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryGrey,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.primaryIcon({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primaryIcon,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryIcon({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryIcon,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryIconFix({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryIconFix,
        actionStatus: actionStatus,
        icon: icon,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 42.hr,
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
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryGrey:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(color: kSofterGrey)),
        );
      case AppButtonType.primaryIcon:
        return ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondaryIcon:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryIconFix:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
    }
  }

  Widget _onLoading() {
    return Center(
      child: SizedBox(
        height: 24.hr,
        width: 24.hr,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: buttonType == AppButtonType.primary ||
                  buttonType == AppButtonType.primaryIcon
              ? Colors.white
              : kPrimaryColor,
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
      case AppButtonType.primaryIcon:
        return _buttonTextPrimary(text ?? 'Button');
      case AppButtonType.secondaryIcon:
        return _buttonTextSecondary(text ?? 'Button');
      case AppButtonType.secondaryIconFix:
        return _buttonIconSecondary();
    }
  }

  Widget _textPrimary(String text) {
    return Center(child: Text(text, style: text14WhiteSemiBold));
  }

  Widget _buttonTextPrimary(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon ?? '',
          colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
        ),
        Gap(8.w),
        Text(text, style: text14WhiteSemiBold),
      ],
    );
  }

  Widget _textSecondary(String text) {
    return Center(
        child: Text(text,
            style: onPressed == null
                ? text14WhiteSemiBold
                : text14PrimarySemiBold));
  }

  Widget _buttonTextSecondary(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Gap(8.w),
        SvgPicture.asset(
          icon ?? '',
          colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
          height: 13.r,
          width: 13.r,
          fit: BoxFit.cover,
        ),
        Gap(8.w),
        Text(text,
            style: onPressed == null
                ? text14WhiteSemiBold
                : text14PrimarySemiBold),
        Gap(8.w),
      ],
    );
  }

  Widget _textSecondaryGrey(String text) {
    return Center(child: Text(text, style: text14HintRegular));
  }

  Widget _buttonIconSecondary() {
    return SvgPicture.asset(
      icon ?? '',
      colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      height: 20.r,
      width: 20.r,
      fit: BoxFit.cover,
    );
  }
}
