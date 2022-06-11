import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/home/home_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class InformationPage extends StatefulWidget {
  InformationPage({Key? key}) : super(key: key);

  @override
  _InformationPageState createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late HomeCubit homeCubit;

  TextEditingController storeName = TextEditingController();
  TextEditingController storeAddress = TextEditingController();
  TextEditingController personalName = TextEditingController();
  TextEditingController personalEmail = TextEditingController();
  TextEditingController personalPhone = TextEditingController();

  @override
  void initState() {
    homeCubit = BlocProvider.of<HomeCubit>(context);
    storeName.text = homeCubit.user.storeName!;
    storeAddress.text = homeCubit.user.storeAddress!;
    personalName.text = homeCubit.user.fullname!;
    personalEmail.text = homeCubit.user.email!;
    personalPhone.text = homeCubit.user.phoneNumber!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: homeCubit,
      listener: (context, state) {
        if (state is ErrorUpdatePersonalData) {
          Navigator.of(context).pop();
          AppAlertDialog(
                  title: "Perubahan informasi gagal",
                  description: "Gagal melakukan perubahan data",
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () => Navigator.of(context).pop())
              .show(context);
        } else if (state is SuccessUpdatePersonalData) {
          Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        } else if (state is HomeInitial) {
          LoadingDialog(
                  title: "Melakukan perubahan ...",
                  description: "Mohon tunggu beberapa saat.")
              .show(context);
        }
      },
      child: BlocBuilder(
        bloc: homeCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              title: Text(
                "Informasi Usaha",
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
            body: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formkey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        AddInput(
                          label: "Nama usaha",
                          isRequired: true,
                          controller: storeName,
                          hint: "e.g Sumber Rejeki",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama warung masih kosong";
                            }

                            return null;
                          },
                        ),
                        AddInput(
                          label: "Alamat usaha",
                          isRequired: true,
                          controller: storeAddress,
                          hint: "e.g Jalan merauke",
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Alamat warung masih kosong";
                            }

                            return null;
                          },
                        ),
                        AddInput(
                          label: "Nama lengkap",
                          controller: personalName,
                          hint: "e.g Joko Widodo",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama lengkap masih kosong";
                            }
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Nomor telepon",
                          controller: personalPhone,
                          hint: "e.g 08127371232",
                          type: TextInputType.phone,
                          validation: (value) {
                            return null;
                          },
                        ),
                        AddInput(
                          label: "Email",
                          hint: "e.g joko@gmail.com",
                          controller: personalEmail,
                          isRequired: true,
                          type: TextInputType.number,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Email masih kosong";
                            }

                            return null;
                          },
                        ),
                      ],
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
                text: "Simpan Informasi",
                onPressed: () {
                  AppAlertDialog(
                      title: 'Konfirmasi perubahan data',
                      description: 'Apakah data yang anda berikan sudah benar?',
                      positiveButtonText: 'Ya',
                      positiveButtonOnTap: () {
                        homeCubit.user.email = personalEmail.text;
                        homeCubit.user.fullname = personalName.text;
                        homeCubit.user.phoneNumber = personalPhone.text;
                        homeCubit.user.storeName = storeName.text;
                        homeCubit.user.storeAddress = storeAddress.text;
                        homeCubit.updateUser();
                        Navigator.pop(context);
                      },
                      negativeButtonText: 'Tidak',
                      negativeButtonOnTap: () =>
                          Navigator.pop(context)).show(context);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
