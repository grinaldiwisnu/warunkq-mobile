import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddInput extends StatelessWidget {
  final String? label, hint;
  final TextEditingController? controller;
  final bool? isRequired;
  final TextInputType? type;
  final FormFieldValidator<String>? validation;
  final bool passwordField;
  final ValueChanged<String>? onChanged;

  const AddInput({
    Key? key,
    @required this.label,
    @required this.hint,
    @required this.controller,
    @required this.validation,
    this.isRequired = false,
    this.type = TextInputType.name,
    this.passwordField = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Row(
              children: [
                Text(
                  this.label!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                this.isRequired!
                    ? Text(
                        "*",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColor.red,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          TextFormField(
            validator: validation!,
            controller: this.controller,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 14.sp,
            ),
            keyboardType: this.type,
            obscureText: passwordField,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: this.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: AppColor.boxGrey,
                  fontWeight: FontWeight.w400),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.boxGrey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primary),
              ),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }
}
