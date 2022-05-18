import 'package:warunkq_apps/core/models/api_response.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/core/models/chart_summary.dart';
import 'package:warunkq_apps/core/models/customer.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/core/models/register.dart';
import 'package:warunkq_apps/core/models/top_selling.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/core/models/user.dart';

abstract class ProductRemote {
  Future<ApiResponse<List<Product>>> find();
  Future<ApiResponse<List<Product>>> create(Product data);
  Future<ApiResponse<List<Product>>> save(Product data);
  Future<ApiResponse> delete(Product data);
}

abstract class CategoryRemote {
  Future<ApiResponse<List<Category>>> find();
  Future<ApiResponse<List<Category>>> create(Category data);
  Future<ApiResponse<List<Category>>> save(Category data);
  Future<ApiResponse> delete(Category data);
}

abstract class CustomerRemote {
  Future<ApiResponse<List<Customer>>> find();
  Future<ApiResponse<List<Customer>>> create(Customer data);
  Future<ApiResponse<List<Customer>>> save(Customer data);
  Future<ApiResponse> delete(Customer data);
}

abstract class OrderRemote {
  Future<ApiResponse<List<Transaction>>> findAll(List<DateTime> dates);
  Future<ApiResponse<List<Transaction>>> find(String orderNumber);
  Future<ApiResponse> create(CartCashier data);
  Future<ApiResponse<ChartSummary>> summary(List<DateTime> dates);
  Future<ApiResponse<List<TopSelling>>> topSelling(List<DateTime> dates);
}

abstract class UserRemote {
  Future<ApiResponse<User>> login(String email, String password);
  Future<ApiResponse<User>> getUserDetail();
  Future<ApiResponse> save(User user);
  Future<ApiResponse> register(Register register);
}
