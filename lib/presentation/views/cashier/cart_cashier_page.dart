import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:warunkq_apps/core/models/detail_order.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/views/cashier/cashier_success_page.dart';
import 'package:warunkq_apps/presentation/views/customer/customer_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/paid_button.dart';

class CartCashierPage extends StatefulWidget {
  CartCashierPage({Key? key}) : super(key: key);

  @override
  _CartCashierPageState createState() => _CartCashierPageState();
}

class _CartCashierPageState extends State<CartCashierPage> {
  late CashierCubit cashierCubit;
  late HomeCubit homeCubit;

  @override
  void initState() {
    cashierCubit = BlocProvider.of<CashierCubit>(context);
    homeCubit = BlocProvider.of<HomeCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.primary,
            elevation: 1,
            title: Text(
              "Pesanan #${cashierCubit.cartCashier.orderNumber}",
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: BlocListener(
            listener: (context, state) {
              if (state is CashierDeleteOrder) {
                Navigator.of(context).pop();
              } else if (state is CashierCreateOrderLoading) {
                LoadingDialog(
                  title: "Transaksi sedang dibuat",
                  description: "Mohon menunggu, transaksi sedang dibuat.",
                ).show(context);
              } else if (state is CashierCreateOrderFailed) {
                Navigator.of(context).pop();
                AppAlertDialog(
                        title: "Gagal membuat transaksi",
                        description: "Sistem gagal mengirimkan transaksi anda.",
                        positiveButtonText: "Oke",
                        positiveButtonOnTap: () => Navigator.of(context).pop())
                    .show(context);
              } else if (state is CashierCreateOrderSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => CashierSuccessPage(
                              data: state.data,
                            )),
                    (Route<dynamic> route) => false);
              }
            },
            bloc: cashierCubit,
            child: BlocBuilder(
              bloc: cashierCubit,
              builder: (context, state) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColor.boxGrey, width: 1)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "#${cashierCubit.cartCashier.orderName}",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CustomerPage()));
                              },
                              child: Icon(
                                Icons.group_add_rounded,
                                color: AppColor.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: ListView.separated(
                            itemCount:
                                cashierCubit.cartCashier.detailOrder.length,
                            separatorBuilder: (context, index) => Divider(),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 15.w),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              DetailOrder data =
                                  cashierCubit.cartCashier.detailOrder[index];
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible:
                                      DismissiblePane(onDismissed: () {}),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {},
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                  ],
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 35.h,
                                            width: 35.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColor.grey,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: AppColor.darkGrey,
                                            ),
                                            child: Text(
                                              GlobalHelper.getInitials(
                                                  data.product!.productName),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w),
                                              child: Text(
                                                "${data.quantity}x " +
                                                    data.product!.productName!,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Rp" +
                                                GlobalHelper.formatPrice(
                                                    data.subTotal),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 15.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(color: AppColor.boxGrey),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Diskon",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColor.black,
                                    size: 14.sp,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(color: AppColor.boxGrey),
                              )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "Rp" +
                                        GlobalHelper.formatPrice(cashierCubit
                                            .cartCashier.totalPrice),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 25.h),
                              child: GestureDetector(
                                onTap: () {
                                  AppAlertDialog(
                                    title: "Hapus order?",
                                    description:
                                        "Hapus order akan menghapus produk yang telah berada di keranjang.",
                                    positiveButtonText: "Oke",
                                    positiveButtonOnTap: () {
                                      cashierCubit.deleteOrder();
                                      Navigator.of(context).pop();
                                    },
                                    negativeButtonOnTap: () =>
                                        Navigator.of(context).pop(),
                                    negativeButtonText: "Batal",
                                  ).show(context);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: AppColor.red,
                                      size: 16.sp,
                                    ),
                                    Text(
                                      "Hapus pesanan",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.red,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                              color: AppColor.disableDarkGrey,
                            )
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24)),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              margin: EdgeInsets.only(top: 15.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Rp" +
                                        GlobalHelper.formatPrice(cashierCubit
                                            .cartCashier.totalPrice),
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            PaidButton(
                              icon: Icons.payments_outlined,
                              isDisabled: false,
                              totalPrice: cashierCubit.cartCashier.totalPrice,
                              totalProduct:
                                  cashierCubit.cartCashier.totalProduct,
                              onTap: () {
                                cashierCubit.createOrder();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
