import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/views/product/product_category_page.dart';
import 'package:warunkq_apps/presentation/views/product/product_page.dart';
import 'package:warunkq_apps/presentation/widgets/components/store_menu.dart';

class StorePage extends StatelessWidget {
  const StorePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Warung Rizky Sejahtera",
            style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500),
          ),
          backgroundColor: AppColor.primary,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                color: AppColor.primary,
                padding: EdgeInsets.only(bottom: 20.h, right: 15.w, left: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 10.sp),
                            height: 60.h,
                            width: 60.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "GW",
                              style: TextStyle(
                                fontSize: 36.sp,
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
                                    "Grinaldi Wisnu Tri Prasetyo",
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "grinaldifoc@gmail.com",
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.darkGrey,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    "+62 852 3002 6622",
                                    style: TextStyle(
                                      fontSize: 14.sp,
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
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                              onTap: () {},
                            ),
                            StoreMenu(
                              name: "Daftar Pelanggan",
                              icon: Icons.supervisor_account_rounded,
                              onTap: () {},
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
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
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
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Keluar",
                                style: TextStyle(
                                  color: AppColor.red,
                                  fontSize: 16.sp,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
