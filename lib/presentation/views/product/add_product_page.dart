import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';

class AddProductPage extends StatefulWidget {
  AddProductPage({Key key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 175.w,
                  height: 125.h,
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
                controller: TextEditingController(),
                hint: "e.g Minyak goreng",
              ),
              AddInput(
                label: "SKU",
                controller: TextEditingController(),
                hint: "e.g 192381391293",
              ),
              Row(
                children: [
                  Expanded(
                    child: AddInput(
                      label: "Harga pokok produk",
                      isRequired: true,
                      controller: TextEditingController(),
                      hint: "e.g 5000",
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Expanded(
                    child: AddInput(
                      label: "Harga jual produk",
                      isRequired: true,
                      controller: TextEditingController(),
                      hint: "e.g 6000",
                    ),
                  ),
                ],
              ),
              AddInput(
                label: "Stok produk",
                hint: "e.g 50",
                controller: TextEditingController(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
