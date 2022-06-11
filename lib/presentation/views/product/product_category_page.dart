import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/views/product/add_product_category_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_indicator.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class ProductCategoryPage extends StatefulWidget {
  ProductCategoryPage({Key? key}) : super(key: key);

  @override
  _ProductCategoryPageState createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  late CategoryCubit categoryCubit;

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
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 1,
      ),
      body: BlocListener(
        bloc: categoryCubit,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: categoryCubit,
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
                      onChanged: (str) {
                        categoryCubit.search(str);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: AppColor.grey,
                      child: state is CategoryLoading
                          ? LoadingIndicator()
                          : ListView.builder(
                              itemCount: categoryCubit.listCategory.length,
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 15.w),
                              itemBuilder: (context, index) {
                                Category data =
                                    categoryCubit.listCategory[index];
                                return GestureDetector(
                                  onTap: () => Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddProductCategoryPage(
                                                category: data,
                                              ))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                              color: AppColor.boxGrey,
                                              blurRadius: 2,
                                              spreadRadius: 0,
                                              offset: Offset(0, 0))
                                        ]),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.w),
                                    margin: EdgeInsets.only(bottom: 5.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${data.name}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        Text(
                                          GlobalHelper.isEmpty(data.description)
                                              ? "-"
                                              : data.description!,
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.normal,
                                              color: AppColor.darkGrey),
                                        ),
                                      ],
                                    ),
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
                            builder: (context) => AddProductCategoryPage()));
                      },
                      text: "Tambah Kategori",
                      radius: 8,
                      padding: 16,
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
