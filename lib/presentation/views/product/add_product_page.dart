import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({Key key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ProductCubit productCubit;
  CategoryCubit categoryCubit;
  TextEditingController productName,
      productSKU,
      productHPP,
      productHJP,
      productStock = TextEditingController();

  @override
  void initState() {
    productCubit = BlocProvider.of<ProductCubit>(context);
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Tambah Produk",
          style: TextStyle(
            fontSize: 18.sp,
            color: Colors.white,
          ),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 180,
                    height: 150.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.boxGrey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 36.sp,
                          color: AppColor.darkGrey,
                        ),
                        Text(
                          "Tambahkan gambar produk",
                          style: TextStyle(
                            color: AppColor.darkGrey,
                            fontSize: 12.sp,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                AddInput(
                  label: "Nama produk",
                  isRequired: true,
                  controller: productName,
                  hint: "e.g Minyak goreng",
                ),
                AddInput(
                  label: "SKU",
                  controller: productSKU,
                  hint: "e.g 192381391293",
                  type: TextInputType.number,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AddInput(
                        label: "Harga pokok produk",
                        isRequired: true,
                        controller: productHPP,
                        hint: "e.g 5000",
                        type: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: AddInput(
                        label: "Harga jual produk",
                        isRequired: true,
                        controller: productHJP,
                        hint: "e.g 6000",
                        type: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                AddInput(
                  label: "Stok produk",
                  hint: "e.g 50",
                  controller: productStock,
                  isRequired: true,
                  type: TextInputType.number,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Row(
                          children: [
                            Text(
                              "Kategori produk",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColor.black,
                              ),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "*",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.normal,
                                color: AppColor.red,
                              ),
                            )
                          ],
                        ),
                      ),
                      DropdownButtonFormField(
                        items: categoryCubit.listCaategory.map((e) {
                          return DropdownMenuItem(
                            child: Text(e.name),
                          );
                        }),
                        style: TextStyle(
                          color: AppColor.black,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.boxGrey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: AppColor.primary),
                          ),
                          isDense: true,
                        ),
                        isDense: true,
                        isExpanded: true,
                        onChanged: (val) {},
                        elevation: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          fontSize: 16.sp,
          padding: 20,
          text: "Simpan Produk",
          onPressed: () {},
        ),
      ),
    );
  }
}
