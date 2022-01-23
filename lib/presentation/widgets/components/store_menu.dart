import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoreMenu extends StatelessWidget {
  final String? name;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool? isLast;

  const StoreMenu(
      {Key? key,
      @required this.name,
      @required this.icon,
      @required this.onTap,
      this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: !this.isLast! ? BorderSide(color: AppColor.boxGrey.withOpacity(0.5), width: 1.5) : BorderSide(color: Colors.transparent),
            )),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 10.w),
              child: Icon(
                this.icon,
                color: AppColor.black,
                size: 18.sp,
              ),
            ),
            Expanded(
              child: Text(
                this.name!,
                style: TextStyle(
                  color: AppColor.black,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.w),
              child: Icon(
                Icons.arrow_right_rounded,
                color: AppColor.black,
                size: 18.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
