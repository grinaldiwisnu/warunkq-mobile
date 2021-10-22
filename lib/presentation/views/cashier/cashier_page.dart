import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/views/cashier/cart_cashier_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/paid_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/product_card.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class CashierPage extends StatefulWidget {
  CashierPage({Key key}) : super(key: key);

  @override
  _CashierPageState createState() => _CashierPageState();
}

class _CashierPageState extends State<CashierPage> {
  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: EdgeInsets.only(right: 15.w),
            alignment: Alignment.centerRight,
            child: Text(
              "Warung Rizky Sejahtera",
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
                  ),
                  child: SearchBar(
                    controller: TextEditingController(),
                    label: "Cari produk yang dibeli",
                  ),
                ),
                Expanded(
                  child: Container(
                      color: AppColor.grey,
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 15.h),
                        childAspectRatio: 8.5 / 9.0,
                        children: List.generate(9, (index) {
                          return ProductCard(
                            isBestSeller: true,
                            productInitial: "SKM",
                            productName: "Susu Kental Manis (Frisian Flag)",
                            productPrice: "16.000",
                            productStock: "25",
                            onTap: () {
                              print("ini produk $index");
                            },
                          );
                        }),
                      )),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: PaidButton(
                isDisabled: false,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CartCashierPage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
