import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/views/cashier/cart_cashier_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_indicator.dart';
import 'package:warunkq_apps/presentation/widgets/components/paid_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/product_card.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class CashierPage extends StatefulWidget {
  CashierPage({Key key}) : super(key: key);

  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  CashierCubit cashierCubit;
  ProductCubit productCubit;
  HomeCubit homeCubit;

  @override
  void initState() {
    cashierCubit = BlocProvider.of<CashierCubit>(context);
    productCubit = BlocProvider.of<ProductCubit>(context);
    homeCubit = BlocProvider.of<HomeCubit>(context);
    productCubit.load();
    homeCubit.init();
    super.initState();
  }

  Future<Null> refreshProduct() async {
    productCubit.load();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener(
          cubit: productCubit,
          listener: (context, state) {
            if (state is LoadProductFailed) {
              AppAlertDialog(
                  title: "Gagal mendapatkan produk",
                  description:
                      "Sistem gagal mendapatkan produk anda, silahkan cek koneksi anda.",
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () =>
                      Navigator.of(context).pop()).show(context);
            }
          },
        )
      ],
      child: BlocBuilder(
        cubit: cashierCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              automaticallyImplyLeading: false,
              title: Container(
                height: 25.h,
                width: 25.w,
                child: SvgPicture.asset(
                  "assets/logo.svg",
                ),
              ),
              actions: [
                BlocBuilder(
                  cubit: homeCubit,
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.only(right: 15.w),
                      alignment: Alignment.centerRight,
                      child: Text(
                        !GlobalHelper.isEmpty(homeCubit.user)
                            ? homeCubit.user.storeName
                            : "",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
            body: Container(
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFFE0E0E0), width: 0.5)),
                        ),
                        child: SearchBar(
                          controller: TextEditingController(),
                          label: "Cari produk yang dibeli",
                        ),
                      ),
                      BlocBuilder(
                        cubit: productCubit,
                        builder: (context, state) {
                          return Expanded(
                            child: Container(
                                color: AppColor.grey,
                                child: RefreshIndicator(
                                  onRefresh: refreshProduct,
                                  child: state is ProductLoading ? LoadingIndicator() : GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 2,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 15.h),
                                    children: List.generate(
                                        productCubit.listProduct.length,
                                        (index) {
                                      Product data =
                                          productCubit.listProduct[index];
                                      return ProductCard(
                                        isBestSeller: false,
                                        data: data,
                                        onTap: () {
                                          cashierCubit.addItem(data);
                                        },
                                      );
                                    }),
                                  ),
                                )),
                          );
                        },
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: PaidButton(
                      icon: Icons.shopping_basket_outlined,
                      isDisabled: cashierCubit.cartCashier.totalProduct > 0 ? false : true,
                      totalPrice: cashierCubit.cartCashier.totalPrice,
                      totalProduct: cashierCubit.cartCashier.totalProduct,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartCashierPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
