import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warunkq_apps/core/data/remote/customer_api.dart';
import 'package:warunkq_apps/core/remote.dart';
import 'package:warunkq_apps/core/data/remote/category_api.dart';
import 'package:warunkq_apps/core/data/remote/order_api.dart';
import 'package:warunkq_apps/core/data/remote/product_api.dart';
import 'package:warunkq_apps/core/data/remote/user_api.dart';
import 'package:warunkq_apps/core/usecase.dart';
import 'package:warunkq_apps/core/usecases/category_usecase.dart';
import 'package:warunkq_apps/core/usecases/customer_usecase.dart';
import 'package:warunkq_apps/core/usecases/order_usecase.dart';
import 'package:warunkq_apps/core/usecases/product_usecase.dart';
import 'package:warunkq_apps/core/usecases/user_usecase.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/order/order_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/report/report_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => AuthCubit(
    userUC: sl(),
  ));
  sl.registerFactory(() => CashierCubit(
    orderUC: sl(),
  ));
  sl.registerFactory(() => CategoryCubit(
    categoryUC: sl(),
  ));
  sl.registerFactory(() => HomeCubit(
    userData: sl(),
  ));
  sl.registerFactory(() => OrderCubit(
    orderUC: sl(),
  ));
  sl.registerFactory(() => ProductCubit(
    productUC: sl(),
  ));
  sl.registerFactory(() => ReportCubit(
    orderUC: sl(),
  ));

  // UseCase
  sl.registerLazySingleton<UserUC>(() => UserUsecase(sl(), sl()));
  sl.registerLazySingleton<ProductUC>(() => ProductUsecase(sl()));
  sl.registerLazySingleton<CategoryUC>(() => CategoryUsecase(sl(), sl()));
  sl.registerLazySingleton<OrderUC>(() => OrderUsecase(sl(), sl()));
  sl.registerLazySingleton<CustomerUC>(() => CustomerUsecase(sl(), sl()));

  // Data
  sl.registerLazySingleton<ProductRemote>(() => ProductAPI());
  sl.registerLazySingleton<OrderRemote>(() => OrderAPI());
  sl.registerLazySingleton<CategoryRemote>(() => CategoryAPI());
  sl.registerLazySingleton<UserRemote>(() => UserAPI());
  sl.registerLazySingleton<CustomerRemote>(() => CustomerAPI());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}