import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/presentation/cubit/customer/customer_cubit.dart';
import 'package:warunkq_apps/presentation/views/customer/add_customer_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/search_bar.dart';

class CustomerPage extends StatefulWidget {
  final bool isFromCashier;
  CustomerPage({Key? key, this.isFromCashier = false}) : super(key: key);

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  late CustomerCubit customerCubit;

  @override
  void initState() {
    customerCubit = BlocProvider.of<CustomerCubit>(context);
    super.initState();
  }

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
                  onChanged: (str) {
                    customerCubit.search(str);
                  },
                ),
              ),
              Expanded(
                child: BlocListener(
                  bloc: customerCubit,
                  listener: (context, state) {},
                  child: BlocBuilder(
                    bloc: customerCubit,
                    builder: (context, state) {
                      return Container(
                        color: AppColor.grey,
                        child: ListView.builder(
                          itemCount: customerCubit.listCustomer.length,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (this.widget.isFromCashier) {
                                  Navigator.of(context)
                                      .pop(customerCubit.listCustomer[index]);
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddCustomerPage(
                                            customer: customerCubit
                                                .listCustomer[index],
                                          )));
                                }
                              },
                              child: Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${customerCubit.listCustomer[index].name}",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${customerCubit.listCustomer[index].phone}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
                        builder: (context) => AddCustomerPage()));
                  },
                  text: "Tambah Pelanggan",
                  radius: 8,
                  padding: 15,
                ),
              )
            ],
          ),
        ));
  }
}
