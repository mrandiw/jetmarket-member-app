import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jetmarket/presentation/home_pages/location/section/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatefulWidget {
  final Key? formKey;
  final AutovalidateMode autovalidateMode;
  final void Function()? onTap;
  final bool readOnly;
  final TextEditingController controller;
  final bool obscureText;
  final int? maxLength;
  final int? maxLines;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomForm({
    super.key, 
    required this.formKey, 
    required this.autovalidateMode,
    this.onTap,
    this.readOnly = false, 
    required this.controller, 
    this.obscureText = false,
    this.maxLength,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.hint,
    this.prefixIcon,
    this.suffixIcon
  });

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: TextFormField(
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        controller: widget.controller,
        obscureText: widget.obscureText,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        validator: widget.validator,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormatters,
        onFieldSubmitted: widget.onFieldSubmitted,
        keyboardType: widget.keyboardType,
        textAlign: widget.textAlign,
        decoration: InputDecoration(
          hintText: widget.hint,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          counterText: '',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: AppColors.contextGrey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(formRadius.sp),
            borderSide: BorderSide(
              color: AppColors.formBorderColor
            )
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(formRadius.sp),
            borderSide: const BorderSide(
              color: Colors.black
            )
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(formRadius.sp),
            borderSide: const BorderSide(
              color: Colors.red
            )
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(formRadius.sp),
            borderSide: const BorderSide(
              color: Colors.red
            )
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(formRadius.sp),
            borderSide: BorderSide(
              color: AppColors.formBorderColor
            )
          ),
          contentPadding: const EdgeInsets.all(16),
          errorMaxLines: 3
        )
      )
    );
  }
}