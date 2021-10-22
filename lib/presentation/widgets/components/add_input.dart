import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddInput extends StatelessWidget {
  final String label, hint;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType type;

  const AddInput({
    Key key,
    @required this.label,
    @required this.hint,
    @required this.controller,
    this.isRequired = false,
    this.type = TextInputType.name,
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
                  this.label,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColor.black,
                  ),
                ),
                SizedBox(
                  width: 3.w,
                ),
                this.isRequired
                    ? Text(
                        "*",
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.normal,
                          color: AppColor.red,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          TextFormField(
            controller: this.controller,
            style: TextStyle(
              color: AppColor.black,
              fontSize: 16.sp,
            ),
            keyboardType: this.type,
            decoration: InputDecoration(
              hintText: this.hint,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintStyle: TextStyle(
                  fontSize: 16.sp,
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
