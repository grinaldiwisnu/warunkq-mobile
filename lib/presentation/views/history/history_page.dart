import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          "Riwayat Pembelian",
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
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_rounded,
                        color: AppColor.black,
                        size: 20.sp,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Text(
                        "12 Okt 2021 - 13 Okt 2021",
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColor.black,
                    size: 20.sp,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.grey,
                child: ListView.builder(
                  itemCount: 5,
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 15.w),
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Rp115.450",
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black,
                                  ),
                                ),
                                Text(
                                  "10.00 AM - #WQ-19238291",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.normal,
                                    color: AppColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColor.primary,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                            child: Text(
                              "SELESAI",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
