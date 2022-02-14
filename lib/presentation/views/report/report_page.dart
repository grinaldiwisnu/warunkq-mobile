import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:warunkq_apps/presentation/widgets/components/point_line_chart.dart';

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        automaticallyImplyLeading: false,
        elevation: 1,
        title: Text(
          "Laporan Penjualan",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: 15.w, right: 15.w, top: 10.h, bottom: 10.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxGrey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.boxGrey, width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rangkuman Penjualan",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250.h,
                      padding: EdgeInsets.all(10),
                      child: PointLineChart.withSampleData(),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Laba kotor",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.darkGrey,
                                ),
                              ),
                              Text(
                                "Rp543.000",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Laba bersih",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.darkGrey,
                                ),
                              ),
                              Text(
                                "Rp233.000",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Penggunaan diskon",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.darkGrey,
                                ),
                              ),
                              Text(
                                "Rp43.000",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Produk terjual",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.darkGrey,
                                ),
                              ),
                              Text(
                                "132 produk",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.w, right: 15.w, top: 5.h),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.boxGrey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: AppColor.boxGrey, width: 1),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Produk Terlaris",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wagyu Sate",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Rp330.000",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "60%",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                                Text(
                                  "30 terjual",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            width: double.infinity,
                            height: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.6,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.greenSecondary),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wagyu Sate",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Rp330.000",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "60%",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                                Text(
                                  "30 terjual",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            width: double.infinity,
                            height: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.6,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.greenSecondary),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Wagyu Sate",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Rp330.000",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "60%",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                                Text(
                                  "30 terjual",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.greenSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5.h),
                            width: double.infinity,
                            height: 10,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              child: LinearProgressIndicator(
                                value: 0.6,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColor.greenSecondary),
                                backgroundColor: Color(0xffD6D6D6),
                              ),
                            ),
                          )
                        ],
                      ),
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

  /// Create one series with sample hard coded data.
  static List<charts.Series<List<int>, int>> _createSampleData() {
    final data = [
      [1, 12],
      [2, 8],
      [3, 25],
      [4, 13]
    ];

    return [
      new charts.Series<List<int>, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (sales, _) => sales.first,
        measureFn: (sales, _) => sales.last,
        data: data,
      )
    ];
  }
}
