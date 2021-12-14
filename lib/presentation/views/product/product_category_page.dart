import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/views/product/add_product_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class ProductCategoryPage extends StatefulWidget {
  ProductCategoryPage({Key key}) : super(key: key);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  CategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    categoryCubit.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Kategori Produk",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocListener(
        cubit: categoryCubit,
        listener: (context, state) {},
        child: BlocBuilder(
          cubit: categoryCubit,
          builder: (context, state) {
            return Container(
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFE0E0E0), width: 0.5)),
                    ),
                    child: SearchBar(
                      controller: TextEditingController(),
                      label: "Cari kategori",
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.grey,
                      child: ListView.builder(
                        itemCount: 4,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.w),
                        itemBuilder: (context, index) {
                          Category data = categoryCubit.listCaategory[index];
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
                                vertical: 20.h, horizontal: 15.w),
                            margin: EdgeInsets.only(bottom: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.name}",
                                  style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                  "${data.description}",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal,
                                      color: AppColor.darkGrey),
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
                      text: "Tambah Kategori",
                      radius: 8,
                      padding: 15,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
