import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/flutter_toast.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/customer_bottom_sheet.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class CashierSuccessPage extends StatelessWidget {
  final CartCashier? data;
  final CashierCubit cashierCubit;
  const CashierSuccessPage({Key? key, this.data, required this.cashierCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: BlocListener(
          bloc: cashierCubit,
          listener: (context, state) {
            if (state is CashierSendReceiptLoading) {
              LoadingDialog(
                title: "Mengirim struk belanja",
                description: "Mohon menunggu, struk belanja sedang dikirim.",
              ).show(context);
            } else if (state is CashierSendReceiptSuccess) {
              Navigator.of(context).pop();
              showFlutterToast("Struk belanja berhasil terkirim");
            } else if (state is CashierSendReceiptFailed) {
              Navigator.of(context).pop();
              AppAlertDialog(
                  title: "Gagal mengirim struk",
                  description: "Sistem gagal mengirimkan struk belanja anda.",
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () => Navigator.of(context).pop())
                  .show(context);
            }
          },
          child: BlocBuilder(
            bloc: cashierCubit,
            builder: (context, state) {
              return Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.check,
                            color: AppColor.green,
                            size: 36,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 25.h),
                          child: Text(
                            "Pesanan berhasil dibuat!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 5.h),
                          child: Text(
                            "Pesanan #${data!.orderNumber!}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                            EdgeInsets.only(left: 15, right: 7.5, bottom: 15),
                            child: BaseButton(
                              style: AppButtonStyle.secondary,
                              onPressed: () {
                                CustomerBottomSheet(cashierCubit).show(context);
                              },
                              text: "Kirim Struk",
                              radius: 8,
                              padding: 15,
                              border: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding:
                            EdgeInsets.only(right: 15, left: 7.5, bottom: 15),
                            child: BaseButton(
                              style: AppButtonStyle.secondary,
                              onPressed: () => Navigator.of(context)
                                  .pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                      (Route<dynamic> route) => false),
                              text: "Buat Pesanan Lain",
                              radius: 8,
                              padding: 15,
                              border: BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
