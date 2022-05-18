import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class CustomerPage extends StatefulWidget {
  CustomerPage({Key? key}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Pelanggan",
          style: TextStyle(
            fontSize: 18.sp,
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
                label: "Cari nama pelanggan",
                onChanged: (str) {},
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
                          vertical: 15  .h, horizontal: 15.w),
                      margin: EdgeInsets.only(bottom: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Customer $index",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "08127318231321",
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.normal),
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
                onPressed: () {},
                text: "Tambah Pelanggan",
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
