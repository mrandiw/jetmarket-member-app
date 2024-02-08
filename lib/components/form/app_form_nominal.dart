import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';

class AppFormNominal extends StatelessWidget {
  const AppFormNominal({
    super.key,
    required this.controller,
    this.focusNode,
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      width: Get.width,
      child: TextFormField(
          focusNode: focusNode,
          controller: controller,
          cursorColor: kPrimaryColor,
          style: text12BlackRegular,
          textAlign: TextAlign.left,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          keyboardType: TextInputType.number,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
              hintStyle: text12HintForm,
              filled: true,
              fillColor: kWhite,
              border: border,
              enabledBorder: border,
              focusedBorder: border,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
              prefix: Text('Rp. ', style: text12BlackRegular),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 24.h, minWidth: 42.w))),
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
