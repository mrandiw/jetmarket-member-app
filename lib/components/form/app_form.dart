import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../infrastructure/theme/app_colors.dart';

enum AppFormType { normal, withLabel }

class AppForm extends StatelessWidget {
  const AppForm({
    super.key,
    required this.controller,
    this.label,
    this.icon,
    this.isError = false,
    this.hintText,
    this.textAlign,
    this.type = AppFormType.normal,
    this.textArea = false,
    this.keyboardType,
    this.focusNode,
    this.onChanged,
  });

  final TextEditingController controller;
  final String? label;
  final String? icon;
  final bool isError;
  final String? hintText;
  final TextAlign? textAlign;
  final AppFormType type;
  final bool textArea;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return type == AppFormType.normal ? _buildNormalForm : _buildWithLabel;
  }

  Widget get _buildNormalForm {
    return SizedBox(
      height: textArea ? 70.h : 44.h,
      width: Get.width,
      child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: kPrimaryColor,
          style: text12BlackRegular,
          maxLines: textArea ? 5 : 1,
          textAlign: textAlign ?? TextAlign.left,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: text12HintForm,
            border: border,
            enabledBorder: isError ? errorBorder : border,
            focusedBorder: isError ? errorBorder : border,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
          )),
    );
  }

  Widget get _buildWithLabel {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label ?? 'Label', style: text12BlackRegular),
        Gap(8.h),
        _buildNormalForm
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
