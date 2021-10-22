import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/views/product/add_product_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Produk Saya",
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
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
              ),
              child: SearchBar(
                controller: TextEditingController(),
                label: "Cari produk",
              ),
            ),
            Expanded(
              child: Container(
                color: AppColor.grey,
                child: ListView.builder(
                  itemCount: 4,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.boxGrey,
                                blurRadius: 2,
                                spreadRadius: 0,
                                offset: Offset(0, 0))
                          ]),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.h, horizontal: 15.w),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColor.grey, width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.disableDarkGrey,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          "Premium XL (16 Kombinasi 750ml) Salad Sayur",
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 8.h),
                                        child: Text(
                                          "SKU 1029301239819283",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: AppColor.darkGrey,
                                            fontSize: 12.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                "Rp23.000",
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
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: BaseButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddProductPage()));
                },
                text: "Tambah Produk",
                radius: 8,
                padding: 15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
