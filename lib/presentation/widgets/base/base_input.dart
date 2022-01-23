import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final bool? passwordField;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final VoidCallback? onClick;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final TextCapitalization? textCapitalization;
  final Color? backgroundColor;
  final ValueChanged<String>? onChanged;

  BaseInput(
      {@required this.controller,
      @required this.label,
      this.passwordField = false,
      this.onClick,
      this.keyboardType = TextInputType.text,
      this.suffixWidget,
      this.validator,
      this.maxLines,
      this.textCapitalization,
      this.backgroundColor,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    if (onClick != null) {
      return Stack(
        children: [
          _buildTextFormField(context),
          Container(
            height: 40.h,
            width: double.infinity,
            child: GestureDetector(
              onTap: onClick,
            ),
          )
        ],
      );
    } else {
      return _buildTextFormField(context);
    }
  }

  Widget _buildTextFormField(context) {
    return TextFormField(
      controller: controller,
      keyboardType: maxLines != null ? TextInputType.multiline : keyboardType,
      maxLines: maxLines,
      obscureText: passwordField!,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      readOnly: onClick != null,
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          filled: backgroundColor != null ? true : false,
          hintText: label,
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              color: AppColor.boxGrey),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.boxGrey, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: AppColor.boxGrey, width: 1.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
          fillColor: backgroundColor ?? Colors.transparent,
          focusColor: backgroundColor ?? Colors.transparent,
          suffixIcon: suffixWidget ?? Container(width: 2.w)),
    );
  }
}
