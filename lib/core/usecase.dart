import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/models/register.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/models/user.dart';
import 'package:warunkq_apps/core/resources/state.dart';

abstract class OrderUC {
  Future<DataState<List<Transaction>>> get({List<DateTime>? dates, String? orderNumber});
  Future<DataState> store(CartCashier data);
  Future<DataState<ChartSummary>> summary(List<DateTime> dates);
  Future<DataState<List<TopSelling>>> topSelling(List<DateTime> dates);
}

abstract class CategoryUC {
  Future<DataState<List<Category>>> get();
  Future<DataState<List<Category>>> store(Category data);
  Future<DataState<List<Category>>> update(Category data);
}

abstract class ProductUC {
  Future<DataState<List<Product>>> get();
  Future<DataState<List<Product>>> store(Product data);
  Future<DataState<List<Product>>> update(Product data);
}

abstract class UserUC {
  Future<DataState<User>> login(String email, String password);
  Future<DataState> register(Register register);
}