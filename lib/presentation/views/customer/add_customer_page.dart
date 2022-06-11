import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/customer.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/customer/customer_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class AddCustomerPage extends StatefulWidget {
  final Customer? customer;
  AddCustomerPage({Key? key, this.customer}) : super(key: key);

  @override
  _AddCustomerPageState createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String title = "Tambah Pelanggan";

  late CustomerCubit customerCubit;
  TextEditingController customerName = TextEditingController();
  TextEditingController customerPhone = TextEditingController();

  @override
  void initState() {
    customerCubit = BlocProvider.of<CustomerCubit>(context);
    if (!GlobalHelper.isEmpty(widget.customer)) {
      customerName.text = widget.customer!.name!;
      customerPhone.text = widget.customer!.phone!;
      title = "Ubah Pelanggan";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          title,
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
      backgroundColor: Colors.white,
      body: BlocListener(
        bloc: customerCubit,
        listener: (context, state) {
          if (state is CustomerInitial) {
            LoadingDialog(
                    title: "Loading ...",
                    description: "Sedang megirim ke sistem.")
                .show(context);
          } else if (state is AddCustomerFailed ||
              state is UpdateCustomerFailed) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Gagal!",
              description: "Gagal menyimpan pelanggan ke sistem.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                Navigator.of(context).pop();
              },
            ).show(context);
          } else if (state is AddCustomerSuccess) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Berhasil!",
              description: "Berhasil menambahkan pelanggan produk.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                customerCubit.load();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ).show(context);
          } else if (state is UpdateCustomerSuccess) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Berhasil!",
              description: "Berhasil merubah pelanggan produk.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                customerCubit.load();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ).show(context);
          }
        },
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Container(
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
                      label: "Nama pelanggan",
                      isRequired: true,
                      controller: customerName,
                      hint: "e.g General",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama produk masih kosong";
                        }

                        return null;
                      },
                    ),
                    AddInput(
                      label: "Nomor telepon pelanggan",
                      controller: customerPhone,
                      hint: "e.g 192381391293",
                      validation: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          padding: 16,
          text: "Simpan Pelanggan",
          onPressed: () {
            Customer customer = Customer(
              phone: customerPhone.text,
              name: customerName.text,
              id: GlobalHelper.isEmpty(widget.customer)
                  ? 0
                  : widget.customer!.id!,
            );

            if (!GlobalHelper.isEmpty(widget.customer)) {
              customerCubit.save(customer);
            } else {
              customerCubit.add(customer);
            }
          },
        ),
      ),
    );
  }
}
