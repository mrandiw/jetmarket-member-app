import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';

import '../../infrastructure/theme/app_colors.dart';
import '../../utils/style/app_style.dart';

enum IconType { prefix, suffix, all }

enum AppFormIconType { normal, withLabel }

class AppFormIcon extends StatefulWidget {
  const AppFormIcon({
    super.key,
    required this.controller,
    this.icon,
    this.isError = false,
    this.errorMessage,
    this.hintText,
    this.isPAssword = false,
    this.samePassword = false,
    this.iconType = IconType.prefix,
    this.type = AppFormIconType.normal,
    this.label,
    this.onChanged,
  });

  const AppFormIcon.password({
    super.key,
    required this.controller,
    this.icon,
    this.isError = false,
    this.errorMessage,
    this.hintText,
    this.isPAssword = true,
    this.samePassword = false,
    this.iconType = IconType.suffix,
    this.type = AppFormIconType.normal,
    this.label,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? icon;
  final bool isError;
  final String? errorMessage;
  final String? hintText;
  final bool isPAssword;
  final bool samePassword;
  final IconType iconType;
  final String? label;
  final AppFormIconType type;
  final Function(String)? onChanged;

  @override
  State<AppFormIcon> createState() => _AppFormIconState();
}

class _AppFormIconState extends State<AppFormIcon> {
  bool showPassword = true;
  setShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPAssword;
  }

  @override
  Widget build(BuildContext context) {
    return widget.type == AppFormIconType.normal
        ? _normalForm
        : _buildWithLabel;
  }

  Widget get _normalForm {
    return SizedBox(
      height: 42.h,
      width: Get.width,
      child: TextFormField(
          obscureText: showPassword,
          controller: widget.controller,
          cursorColor: kPrimaryColor,
          style: text12BlackRegular,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: text12HintForm,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              prefixIcon: widget.iconType == IconType.prefix ||
                      widget.iconType == IconType.all
                  ? SvgPicture.asset(widget.icon ?? '')
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
              prefixIconConstraints: widget.iconType == IconType.prefix ||
                      widget.iconType == IconType.all
                  ? BoxConstraints(maxHeight: 24.h, minWidth: 42.w)
                  : null,
              suffixIcon: widget.iconType == IconType.suffix ||
                      widget.iconType == IconType.all
                  ? widget.isPAssword
                      ? IconButton(
                          onPressed: () => setShowPassword(),
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20.r,
                            color: Colors.grey.shade400,
                          ))
                      : null
                  : null)),
    );
  }

  Widget get _buildWithLabel {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.label ?? 'Label', style: text12BlackRegular),
        Gap(8.h),
        _normalForm
      ]),
    );
  }

  OutlineInputBorder get border {
    return OutlineInputBorder(
        borderRadius: AppStyle.borderRadius8All,
        borderSide: AppStyle.borderSide);
  }

  OutlineInputBorder get errorBorder {
    return OutlineInputBorder(
        borderRadius: AppStyle.borderRadius8All,
        borderSide: AppStyle.borderSide);
  }
}
