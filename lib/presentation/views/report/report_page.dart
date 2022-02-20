import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/core/models/linear_sales.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/report/report_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/components/point_line_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ReportPage extends StatefulWidget {
  ReportPage({Key? key}) : super(key: key);

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late ReportCubit reportCubit;
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));

  List<charts.Series<LinearSales, DateTime>> summaryReport = [];

  @override
  void initState() {
    startDate = DateTime(startDate.year, startDate.month, startDate.day);
    endDate = DateTime(endDate.year, endDate.month, endDate.day);
    reportCubit = BlocProvider.of<ReportCubit>(context);
    reportCubit.load([startDate, endDate]);
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 360)),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );

    if (picked == null) return;

    setState(() {
      startDate = picked.start;
      endDate = picked.end;
    });

    reportCubit.load([startDate, endDate]);
  }

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
      body: BlocListener(
        bloc: reportCubit,
        listener: (context, state) {
          if (state is LoadReportSuccess) {
            summaryReport = reportCubit.summaryReport;
          }
        },
        child: BlocBuilder(
          bloc: reportCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              child: state is LoadingReport ? Center(child: CircularProgressIndicator(),) :
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.w),
                        decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColor.boxGrey, width: 1)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.date_range_rounded,
                                  color: AppColor.black,
                                  size: 16.sp,
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                Text(
                                  "${GlobalHelper.displayDateRange(startDate)} - ${GlobalHelper.displayDateRange(endDate)}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColor.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColor.black,
                              size: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
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
                            padding: EdgeInsets.all(15),
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 275.h,
                            padding: EdgeInsets.all(15),
                            child: PointLineChart(summaryReport, animate: true,),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.h),
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
                                      "Rp${GlobalHelper.formatPrice(reportCubit.dataSummary.total)}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Laba bersih",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.darkGrey,
                                      ),
                                    ),
                                    Text(
                                      "Rp${GlobalHelper.formatPrice(reportCubit.dataSummary.total! - reportCubit.dataSummary.hpp! - reportCubit.dataSummary.discount!)}",
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
                            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
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
                                      "Rp${GlobalHelper.formatPrice(reportCubit.dataSummary.discount)}",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Produk terjual",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppColor.darkGrey,
                                      ),
                                    ),
                                    Text(
                                      "${reportCubit.dataSummary.products} produk",
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
                            padding: EdgeInsets.all(15),
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
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: reportCubit.topProduct.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 8.h),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: AppColor.boxGrey,
                                        width: 1,
                                      ),
                                    )
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              reportCubit.topProduct[index].name!,
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Text(
                                              "Rp" + GlobalHelper.formatPrice(reportCubit.topProduct[index].total),
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.h, bottom: 8),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColor.greenSecondary,
                                              ),
                                            ),
                                            Text(
                                              "${reportCubit.topProduct[index].selling} terjual",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: AppColor.greenSecondary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
