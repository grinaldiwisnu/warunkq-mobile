import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/views/splash_page.dart';

class Entrypoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColor.darkPrimary));

    AuthCubit auth = AuthCubit();
    HomeCubit home = HomeCubit();
    CashierCubit cashier = CashierCubit();
    ProductCubit product = ProductCubit();
    CategoryCubit category = CategoryCubit();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => auth),
        BlocProvider<HomeCubit>(create: (context) => home),
        BlocProvider<CashierCubit>(create: (context) => cashier),
        BlocProvider<ProductCubit>(create: (context) => product),
        BlocProvider<CategoryCubit>(create: (context) => category),
      ],
      child: ScreenUtilInit(
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
      ),
    );
  }

  String logs = "";

  // Call inside a setState({ }) block to be able to reflect changes on screen
  void log(String logString) {
    logs += logString.toString() + "\n";
  }
}
