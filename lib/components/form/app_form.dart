import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:jetmarket/infrastructure/theme/app_text.dart';
import 'package:jetmarket/utils/style/app_style.dart';

import '../../../infrastructure/theme/app_colors.dart';

enum AppFormType { normal, withLabel }

class AppForm extends StatefulWidget {
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
    this.inputFormatters,
    this.onChanged,
    this.onEditingComplete,
    this.errorMessage,
    this.validator,
    this.autovalidateMode,
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
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final String? errorMessage;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  bool isError = false;

  @override
  Widget build(BuildContext context) {
    return widget.type == AppFormType.normal
        ? _buildNormalForm
        : _buildWithLabel;
  }

  Widget get _buildNormalForm {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.textArea
              ? 70.h
              : isError
                  ? 66.h
                  : 44.h,
          width: Get.width,
          child: TextFormField(
              focusNode: widget.focusNode,
              controller: widget.controller,
              cursorColor: kPrimaryColor,
              style: text12BlackRegular,
              maxLines: widget.textArea ? 5 : 1,
              textAlign: widget.textAlign ?? TextAlign.left,
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              onEditingComplete: widget.onEditingComplete,
              validator: (value) {
                final result = widget.validator?.call(value);
                final hasError = result != null;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (isError != hasError) {
                    setState(() {
                      isError = hasError;
                    });
                  }
                });
                return result;
              },
              autovalidateMode: widget.autovalidateMode,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: text12HintForm,
                filled: true,
                fillColor: kWhite,
                border: border,
                enabledBorder: widget.isError ? errorBorder : border,
                focusedBorder: widget.isError ? errorBorder : border,
                errorBorder: errorBorder,
                focusedErrorBorder: errorBorder,
                errorStyle: text10BlackRegular.copyWith(color: kPrimaryColor),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
              )),
        ),
        Visibility(
            visible: widget.isError,
            child: Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Text(widget.errorMessage ?? '',
                    style: text10BlackRegular.copyWith(color: kErrorColor)))),
      ],
    );
  }

  Widget get _buildWithLabel {
    return SizedBox(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.label ?? 'Label', style: text12BlackRegular),
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
        borderSide: const BorderSide(color: kPrimaryColor));
  }
}
