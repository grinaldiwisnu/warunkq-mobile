import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';

class AddProductCategoryPage extends StatefulWidget {
  AddProductCategoryPage({Key key}) : super(key: key);

  @override
  _AddProductCategoryPageState createState() => _AddProductCategoryPageState();
}

class _AddProductCategoryPageState extends State<AddProductCategoryPage> {
  CategoryCubit categoryCubit;
  TextEditingController categoryName, categoryDesc = TextEditingController();

  @override
  void initState() {
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
          "Tambah Kategori",
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
                SizedBox(
                  height: 25.h,
                ),
                AddInput(
                  label: "Nama kategori",
                  isRequired: true,
                  controller: categoryName,
                  hint: "e.g General",
                ),
                AddInput(
                  label: "SKU",
                  controller: categoryDesc,
                  hint: "e.g 192381391293",
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
          text: "Simpan Kategori",
          onPressed: () {},
        ),
      ),
    );
  }
}
