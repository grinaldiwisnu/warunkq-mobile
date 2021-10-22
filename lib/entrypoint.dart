import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/views/splash_page.dart';

class Entrypoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: AppColor.darkPrimary
    ));
    return ScreenUtilInit(
      designSize: Size(375, 812),
      allowFontScaling: true,
      builder: () {
        return MaterialApp(
          title: App().appTitle,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            colorScheme: ColorScheme.light(primary: AppColor.primary),
          ),
          home: SplashPage(),
        );
      },
    );
  }
}
