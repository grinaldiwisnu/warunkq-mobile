import 'package:flutter/material.dart';
import 'package:warunkq_apps/core/models/cart_cashier.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';

class CashierSuccessPage extends StatelessWidget {
  final CartCashier? data;

  const CashierSuccessPage({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.primary,
        body: Container(
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
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    width: double.infinity,
                    child: BaseButton(
                      style: AppButtonStyle.secondary,
                      onPressed: () {},
                      text: "Kirim Struk",
                      radius: 8,
                      padding: 20,
                      border: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    width: double.infinity,
                    child: BaseButton(
                      style: AppButtonStyle.secondary,
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomePage()),
                          (Route<dynamic> route) => false),
                      text: "Buat Pesanan Lain",
                      radius: 8,
                      padding: 20,
                      border: BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
