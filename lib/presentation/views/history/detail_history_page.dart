import 'package:flutter/material.dart';
import 'package:warunkq_apps/core/models/detail_transaction.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class DetailHistoryPage extends StatelessWidget {
  final Transaction data;
  const DetailHistoryPage({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          data.orderId,
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: ListView.separated(
                  itemCount: data.detailOrder.length,
                  separatorBuilder: (context, index) => Divider(),
                  padding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DetailTransaction detail = data.detailOrder[index];
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "${detail.quantity}x " + detail.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Rp" +
                                    GlobalHelper.formatPrice(detail.subTotal),
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
              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
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
                    width: 40,
                    height: 2,
                    margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
                    color: AppColor.boxGrey,
                  ),
                  Container(
                    width: 40,
                    height: 2,
                    color: AppColor.boxGrey,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nama Order",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          data.orderName,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15.h),
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
                            fontSize: 16.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "Rp" + GlobalHelper.formatPrice(data.totalPrice),
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
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
                          "Rp" + GlobalHelper.formatPrice(data.totalPrice),
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColor.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
