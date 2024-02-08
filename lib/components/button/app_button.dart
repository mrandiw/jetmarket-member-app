import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/extension/responsive_size.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../../../utils/network/action_status.dart';

enum AppButtonType {
  primary,
  secondary,
  secondaryGrey,
  primaryIcon,
  secondaryIcon,
  secondaryIconFix,
  primarySmall,
  secondarySmall,
  secondaryGreySmall,
  primaryIconSmall,
  secondaryIconSmall,
  secondaryIconFixSmall,
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

// Small

  factory AppButton.primarySmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primarySmall,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondarySmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondarySmall,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryGreySmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryGreySmall,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.primaryIconSmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primaryIconSmall,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryIconSmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryIconSmall,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );

  factory AppButton.secondaryIconFixSmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? icon,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryIconFixSmall,
        actionStatus: actionStatus,
        icon: icon,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: _getButtonHeight(),
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
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryGrey:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(color: kSofterGrey)),
        );
      case AppButtonType.primaryIcon:
        return ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondaryIcon:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryIconFix:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );

      case AppButtonType.primarySmall:
        return ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          padding: AppStyle.paddingAll8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondarySmall:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: AppStyle.paddingAll8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryGreySmall:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: AppStyle.paddingAll8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: const BorderSide(color: kSofterGrey)),
        );
      case AppButtonType.primaryIconSmall:
        return ElevatedButton.styleFrom(
          backgroundColor: kSecondaryColor,
          elevation: 0,
          padding: AppStyle.paddingAll8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondaryIconSmall:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: AppStyle.paddingAll8,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed == null ? kWhite : kSecondaryColor)),
        );
      case AppButtonType.secondaryIconFixSmall:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: AppStyle.paddingAll8,
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
        return _textPrimary(text ?? 'Button', false);
      case AppButtonType.secondary:
        return _textSecondary(text ?? 'Button', false);

      case AppButtonType.secondaryGrey:
        return _textSecondaryGrey(text ?? 'Button', false);
      case AppButtonType.primaryIcon:
        return _buttonTextPrimary(text ?? 'Button', false);
      case AppButtonType.secondaryIcon:
        return _buttonTextSecondary(text ?? 'Button', false);
      case AppButtonType.secondaryIconFix:
        return _buttonIconSecondary(false);
      case AppButtonType.primarySmall:
        return _textPrimary(text ?? 'Button', true);
      case AppButtonType.secondarySmall:
        return _textSecondary(text ?? 'Button', true);

      case AppButtonType.secondaryGreySmall:
        return _textSecondaryGrey(text ?? 'Button', true);
      case AppButtonType.primaryIconSmall:
        return _buttonTextPrimary(text ?? 'Button', true);
      case AppButtonType.secondaryIconSmall:
        return _buttonTextSecondary(text ?? 'Button', true);
      case AppButtonType.secondaryIconFixSmall:
        return _buttonIconSecondary(true);
    }
  }

  double _getButtonHeight() {
    switch (buttonType) {
      case AppButtonType.primary:
        return 48.hr;
      case AppButtonType.secondary:
        return 48.hr;
      case AppButtonType.secondaryGrey:
        return 48.hr;
      case AppButtonType.primaryIcon:
        return 48.hr;
      case AppButtonType.secondaryIcon:
        return 48.hr;
      case AppButtonType.secondaryIconFix:
        return 48.hr;
      case AppButtonType.primarySmall:
        return 36.hr;
      case AppButtonType.secondarySmall:
        return 36.hr;
      case AppButtonType.secondaryGreySmall:
        return 36.hr;
      case AppButtonType.primaryIconSmall:
        return 36.hr;
      case AppButtonType.secondaryIconSmall:
        return 36.hr;
      case AppButtonType.secondaryIconFixSmall:
        return 36.hr;
    }
  }

  Widget _textPrimary(String text, bool isSmall) {
    return Center(
        child: Text(text,
            style: isSmall ? text12WhiteMedium : text14WhiteSemiBold));
  }

  Widget _buttonTextPrimary(String text, bool isSmall) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon ?? '',
          colorFilter: const ColorFilter.mode(kWhite, BlendMode.srcIn),
        ),
        Gap(8.w),
        Text(text, style: isSmall ? text12WhiteMedium : text14WhiteSemiBold),
      ],
    );
  }

  Widget _textSecondary(String text, bool isSmall) {
    return Center(
        child: Text(text,
            style: onPressed == null
                ? isSmall
                    ? text12WhiteMedium
                    : text14WhiteSemiBold
                : isSmall
                    ? text12PrimaryMedium
                    : text14PrimarySemiBold));
  }

  Widget _buttonTextSecondary(String text, bool isSmall) {
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
                ? isSmall
                    ? text12WhiteMedium
                    : text14WhiteSemiBold
                : isSmall
                    ? text12PrimaryMedium
                    : text14PrimarySemiBold),
        Gap(8.w),
      ],
    );
  }

  Widget _textSecondaryGrey(String text, bool isSmall) {
    return Center(
        child:
            Text(text, style: isSmall ? text12HintRegular : text14HintRegular));
  }

  Widget _buttonIconSecondary(bool isSmall) {
    return SvgPicture.asset(
      icon ?? '',
      colorFilter: const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
      height: 20.r,
      width: 20.r,
      fit: BoxFit.cover,
    );
  }
}
