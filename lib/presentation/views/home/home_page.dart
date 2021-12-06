import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/flutter_toast.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
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
  HomeCubit homeCubit;

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is ErrorPersonalData) {
          showFlutterToast(
              "Failed to get personall data, check your connection.");
        }
      },
      cubit: homeCubit,
      child: Scaffold(
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
              StorePage(
                homeCubit: homeCubit,
              ),
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
      ),
    );
  }
}
