import 'dart:async';

import 'package:flutter/material.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: 5);

    // String isLogin =
    //     App().prefs.getString(ConstantHelper.PREFS_IS_USER_LOGGED_IN);
    // if (isLogin == '1') {
    //   return Timer(_duration, navigationHomePage);
    // } else {
    //   return Timer(_duration, navigationPage);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 285.h,
                width: 285.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage('assets/illustrations/onboard-1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Text(
                  "V 1.0.0",
                  style: TextStyle(
                    fontSize: 14.sp,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
