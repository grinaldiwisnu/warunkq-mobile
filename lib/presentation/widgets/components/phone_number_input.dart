import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  PhoneNumberInput({@required this.controller, @required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      controller: controller,
      style: TextStyle(
          fontSize: 16.sp, color: Colors.black, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: EdgeInsets.fromLTRB(
            8.w,
            9.h,
            15.w,
            9.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(81),
              color: Color(0xFFF4F4F4)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(right: 6.w),
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    offset: const Offset(1, 2),
                    blurRadius: 4,
                  ),
                ]),
                child: SvgPicture.asset(
                  'assets/ic-ina-flag.svg',
                  height: 28.h,
                ),
              ),
              Text("+62",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.black),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
        hintText: "8123-4734-141",
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.sp,
            color: AppColor.boxGrey),
        contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 0.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.boxGrey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColor.boxGrey, width: 1.0),
        ),
      ),
    );
  }
}
