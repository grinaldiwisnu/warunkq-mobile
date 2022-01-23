import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class PaidButton extends StatelessWidget {
  final bool? isDisabled;
  final VoidCallback? onTap;
  final IconData? icon;
  final int? totalPrice, totalProduct;

  const PaidButton({Key? key, this.isDisabled = false, this.onTap, this.icon, this.totalPrice, this.totalProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap!,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: isDisabled! ? AppColor.disableDarkGrey : AppColor.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDisabled!
                    ? AppColor.disableGrey
                    : AppColor.darkPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  topLeft: Radius.circular(8),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    GlobalHelper.formatNumberToString(totalProduct!.toString())!,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Icon(
                    this.icon,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rp" + GlobalHelper.formatPrice(totalPrice),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "Bayar",
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
