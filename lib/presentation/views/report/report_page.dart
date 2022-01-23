import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_indicator.dart';

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
      body: Container(
        child: LoadingIndicator(),
      ),
    );
  }
}
