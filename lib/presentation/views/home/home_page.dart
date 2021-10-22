import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/views/cashier/cashier_page.dart';
import 'package:warunkq_apps/presentation/views/history/history_page.dart';
import 'package:warunkq_apps/presentation/views/report/report_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/views/store/store_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
              pageSnapping: false,
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CashierPage(),
                HistoryPage(),
                ReportPage(),
                StorePage(),
              ],
            ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        backgroundColor: Colors.white,
        elevation: 20,
        selectedItemColor: AppColor.primary,
        unselectedItemColor: AppColor.disableGrey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        selectedFontSize: 14.sp,
        unselectedFontSize: 14.sp,
        onTap: (key) {
          setState(() {
            pageIndex = key;
            _pageController.jumpToPage(key);
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: "Kasir",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded),
            label: "Pembelian",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_rounded),
            label: "Laporan",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store_mall_directory_rounded),
            label: "Toko Saya",
          ),
        ],
      ),
    );
  }
}