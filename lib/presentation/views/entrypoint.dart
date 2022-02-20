import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/injection_container.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/order/order_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/report/report_cubit.dart';
import 'package:warunkq_apps/presentation/views/splash_page.dart';

class Entrypoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: AppColor.darkPrimary));

    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
          BlocProvider<HomeCubit>(create: (context) => sl<HomeCubit>()),
          BlocProvider<CashierCubit>(create: (context) => sl<CashierCubit>()),
          BlocProvider<ProductCubit>(create: (context) => sl<ProductCubit>()),
          BlocProvider<CategoryCubit>(create: (context) => sl<CategoryCubit>()),
          BlocProvider<OrderCubit>(create: (context) => sl<OrderCubit>()),
          BlocProvider<ReportCubit>(create: (context) => sl<ReportCubit>()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: () {
            return MaterialApp(
              title: App().appTitle!,
              debugShowCheckedModeBanner: false,
              color: AppColor.primary,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                colorScheme: ColorScheme.light(primary: AppColor.primary),
              ),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              home: SplashPage(),
            );
          },
        )
    );
  }
}
