import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/views/auth/login_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Selamat datang di WarunkQ!",
              style: TextStyle(
                color: AppColor.black,
                fontWeight: FontWeight.w400,
                fontSize: 24.sp,
              ),
            ),
            Text(
              "Catat transaksimu tiap hari.",
              style: TextStyle(
                color: AppColor.darkGrey,
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Container(
              height: 215.h,
              width: 215.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/manage-order.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
              child: BaseButton(
                style: AppButtonStyle.primary,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                text: "Masuk",
                radius: 8,
                fontSize: 16.sp,
                padding: 20,
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 25.w),
              child: BaseButton(
                style: AppButtonStyle.secondary,
                onPressed: () {},
                text: "Mendaftar",
                radius: 8,
                fontSize: 16.sp,
                padding: 20,
                border: BorderSide(color: AppColor.primary, width: 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
