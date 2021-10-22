import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/views/customer/customer_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/paid_button.dart';

class CartCashierPage extends StatefulWidget {
  CartCashierPage({Key key}) : super(key: key);

  @override
  _CartCashierPageState createState() => _CartCashierPageState();
}

class _CartCashierPageState extends State<CartCashierPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          elevation: 1,
          title: Text(
            "Pesanan #WQ-19238291",
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: AppColor.boxGrey, width: 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#CUST-192381239212",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerPage()));
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
                    itemCount: 5,
                    separatorBuilder: (context, index) => Divider(),
                    padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColor.grey, width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.disableDarkGrey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Text(
                                      "Premium XL (16 Kombinasi 750ml) Salad Sayur",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Rp23.000",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp,
                                  ),
                                )
                              ],
                            ),

                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.boxGrey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Diskon",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.black,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: AppColor.black,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      decoration: BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: AppColor.boxGrey),
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Subtotal",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Rp89.000",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline,
                            color: AppColor.red,
                            size: 18.sp,
                          ),
                          Text(
                            "Hapus pesanan",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.red,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
                      margin: EdgeInsets.only(top: 20.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp89.890",
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColor.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PaidButton(
                      isDisabled: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
