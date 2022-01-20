import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/core/data/remote/user_api.dart';
import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/user.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:warunkq_apps/presentation/views/auth/onboarding_page.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  UserAPI _userAPI = UserAPI();

  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 5);

    bool isLogin = App().prefs.getBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN);
    if (isLogin != null && isLogin) {
      return Timer(_duration, navigationHomePage);
    } else {
      return Timer(_duration, navigationPage);
    }
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => OnboardingPage()));
  }

  void navigationHomePage() async {
    ApiResponse<User> response = await _userAPI.getUserDetail();
    if (response.status != 200) {
      bool _ = await App()
          .prefs
          .setBool(ConstantHelper.PREFS_IS_USER_LOGGED_IN, false);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => OnboardingPage()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 185.h,
                width: 185.w,
                child: SvgPicture.asset(
                  "assets/logo.svg",
                ),
              ),
              Text(
                "WarunkQ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 28.sp,
                ),
              ),
              Text(
                "Permudah jualanmu dengan tap tap!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
