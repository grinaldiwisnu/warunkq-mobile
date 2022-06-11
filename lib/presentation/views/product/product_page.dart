import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/views/product/add_product_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late ProductCubit productCubit;

  @override
  void initState() {
    productCubit = BlocProvider.of<ProductCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Produk Saya",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            productCubit.search("");
            Navigator.of(context).pop();
          },
        ),
        elevation: 1,
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
                onChanged: (str) {
                  productCubit.search(str);
                },
              ),
            ),
            BlocListener(
              bloc: productCubit,
              listener: (context, state) {},
              child: BlocBuilder(
                bloc: productCubit,
                builder: (context, state) {
                  return Expanded(
                    child: Container(
                      color: AppColor.grey,
                      child: ListView.builder(
                        itemCount: productCubit.listProduct.length,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.w),
                        itemBuilder: (context, index) {
                          Product data = productCubit.listProduct[index];

                          return InkWell(
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddProductPage(
                                product: data,
                              ),
                            )),
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
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColor.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColor.darkGrey,
                                        ),
                                        child: Text(
                                          GlobalHelper.getInitials(
                                              data.productName),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Text(
                                                  data.productName!,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    EdgeInsets.only(top: 8.h),
                                                child: Text(
                                                  "${data.description}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
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
                                        "Rp${GlobalHelper.formatPrice(data.price)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
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
                padding: 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
