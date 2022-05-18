import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/app.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/constant_helper.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/views/customer/customer_page.dart';
import 'package:warunkq_apps/presentation/views/product/product_category_page.dart';
import 'package:warunkq_apps/presentation/views/product/product_page.dart';
import 'package:warunkq_apps/presentation/views/splash_page.dart';
import 'package:warunkq_apps/presentation/views/store/information_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/store_menu.dart';

class StorePage extends StatelessWidget {
  final HomeCubit? homeCubit;

  const StorePage({Key? key, this.homeCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            this.homeCubit!.user.storeName!,
            style: TextStyle(
                fontSize: 16.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColor.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  color: AppColor.primary,
                  padding:
                      EdgeInsets.only(bottom: 20.h, right: 15.w, left: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10.sp),
                              height: 60,
                              width: 60,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                GlobalHelper.getInitials(
                                    this.homeCubit!.user.fullname),
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      this.homeCubit!.user.fullname!,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      this.homeCubit!.user.email!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.darkGrey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      this.homeCubit!.user.phoneNumber!,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.darkGrey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  spreadRadius: 0,
                                  color: AppColor.boxGrey,
                                  offset: Offset(0, 0),
                                ),
                              ]),
                          child: Column(
                            children: [
                              StoreMenu(
                                name: "Produk Saya",
                                icon: Icons.card_giftcard_rounded,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ProductPage()));
                                },
                              ),
                              StoreMenu(
                                name: "Kategori Produk",
                                icon: Icons.list_rounded,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProductCategoryPage()));
                                },
                              ),
                              StoreMenu(
                                name: "Info Usaha",
                                icon: Icons.badge,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => InformationPage()));
                                },
                              ),
                              StoreMenu(
                                name: "Daftar Pelanggan",
                                icon: Icons.supervisor_account_rounded,
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CustomerPage()));
                                },
                              ),
                              StoreMenu(
                                name: "Bantuan",
                                icon: Icons.help_outline_rounded,
                                onTap: () {},
                              ),
                              StoreMenu(
                                name: "Kebijakan Pengguna",
                                icon: Icons.verified_user_outlined,
                                onTap: () {},
                              ),
                              StoreMenu(
                                name: "Syarat dan Ketentuan",
                                icon: Icons.article_outlined,
                                onTap: () {},
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        InkWell(
                          onTap: () {
                            AppAlertDialog(
                                title: 'Keluar',
                                description:
                                    'Apakah anda yakin ingin keluar dari akun ini ?',
                                positiveButtonText: 'Ya',
                                positiveButtonOnTap: () {
                                  App().prefs.setBool(
                                      ConstantHelper.PREFS_IS_USER_LOGGED_IN,
                                      false);
                                  App().prefs.setString(
                                      ConstantHelper.PREFS_TOKEN_KEY, "");
                                  App().dio.options.headers = {
                                    'Authorization': null
                                  };
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashPage()),
                                      (Route<dynamic> route) => false);
                                },
                                negativeButtonText: 'Tidak',
                                negativeButtonOnTap: () =>
                                    Navigator.pop(context)).show(context);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 15.h),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2,
                                    color: AppColor.boxGrey,
                                    spreadRadius: 0,
                                    offset: Offset(0, 0),
                                  ),
                                ]),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10.w),
                                  child: Icon(
                                    Icons.logout,
                                    color: AppColor.red,
                                    size: 18.sp,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Keluar",
                                    style: TextStyle(
                                      color: AppColor.red,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
