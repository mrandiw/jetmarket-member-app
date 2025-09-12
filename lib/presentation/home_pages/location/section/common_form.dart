import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jetmarket/presentation/home_pages/location/section/custom_form.dart';

class CommonForm extends StatelessWidget {
  final String label;
  final GlobalKey<FormState> formKey;
  final AutovalidateMode autovalidateMode;
  final TextEditingController textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final String? hint;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CommonForm({
    super.key,
    required this.label,
    required this.formKey,
    required this.autovalidateMode,
    required this.textEditingController,
    this.inputFormatters,
    this.keyboardType,
    this.prefixIcon,
    this.maxLines,
    this.maxLength,
    this.hint,
    this.onChanged,
    this.validator,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: Theme.of(context).textTheme.bodyMedium),
      SizedBox(height: 4.h),
      Material(
        child: CustomForm(
          formKey: formKey,
          autovalidateMode: autovalidateMode,
          controller: textEditingController,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          prefixIcon: prefixIcon,
          maxLines: maxLines,
          maxLength: maxLength,
          readOnly: readOnly ?? false,
          hint: hint,
          onChanged: onChanged,
          validator: validator ??
              (value) {
                if (value!.isEmpty) {
                  return 'Kolom ${label.toLowerCase()} tidak boleh kosong';
                }
                return null;
              },
        ),
      )
    ]);
  }
}
