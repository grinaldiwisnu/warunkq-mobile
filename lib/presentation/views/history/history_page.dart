import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:warunkq_apps/core/models/transaction.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/flutter_toast.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/order/order_cubit.dart';
import 'package:warunkq_apps/presentation/views/history/detail_history_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_indicator.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  OrderCubit orderCubit;
  TextEditingController searchControl = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(Duration(days: 1));

  @override
  void initState() {
    orderCubit = BlocProvider.of<OrderCubit>(context);
    orderCubit.load(startDate: startDate, endDate: endDate);
    super.initState();
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTimeRange picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 300)),
      lastDate: DateTime.now().add(Duration(days: 1)),
      initialDateRange: DateTimeRange(start: startDate, end: endDate),
    );

    if (picked == null) return;

    setState(() {
      startDate = picked.start;
      endDate = picked.end;
    });

    orderCubit.load(startDate: startDate, endDate: endDate);
  }

  Future<Null> refreshOrder() async {
    orderCubit.load(startDate: startDate, endDate: endDate);
  }

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
        body: BlocListener(
          cubit: orderCubit,
          listener: (context, state) {
            if (state is LoadOrderFailed) {
              AppAlertDialog(
                  title: "Gagal mendapatkan transaksi",
                  description:
                      "Sistem gagal mendapatkan transaksi anda, silahkan cek koneksi anda.",
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () =>
                      Navigator.of(context).pop()).show(context);
            } else if (state is SearchOrderFailed) {
              showFlutterToast("Transaksi tidak ditemukan");
            } else if (state is DetailOrderFailed) {
              showFlutterToast("Transaksi tidak ditemukan di sistem");
            } else if (state is DetailOrderSuccess) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailHistoryPage(
                  data: state.data,
                ),
              ));
            }
          },
          child: BlocBuilder(
              cubit: orderCubit,
              builder: (context, state) {
                return Container(
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
                                    size: 20.sp,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    "${GlobalHelper.displayDateRange(startDate)} - ${GlobalHelper.displayDateRange(endDate)}",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.normal),
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
                      ),
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
                          controller: searchControl,
                          label: "Cari transaksi",
                          onChanged: (value) {
                            orderCubit.search(value);
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                            color: AppColor.grey,
                            child: RefreshIndicator(
                              onRefresh: refreshOrder,
                              child: state is OrderLoading
                                  ? LoadingIndicator()
                                  : ListView.builder(
                                      itemCount: orderCubit.listOrder.length,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.h, horizontal: 15.w),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        Transaction data =
                                            orderCubit.listOrder[index];

                                        return GestureDetector(
                                          onTap: () {
                                            orderCubit.prepareDetail(data);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 25.h,
                                                horizontal: 15.w),
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.white,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Rp" +
                                                            GlobalHelper
                                                                .formatPrice(data
                                                                    .totalPrice),
                                                        style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${GlobalHelper.displayDate(DateTime.parse(data.createdAt))} - #${data.orderId}",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: AppColor.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: AppColor.primary,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.h,
                                                      horizontal: 15.w),
                                                  child: Text(
                                                    "SELESAI",
                                                    style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                            )),
                      )
                    ],
                  ),
                );
              }),
        ));
  }
}
