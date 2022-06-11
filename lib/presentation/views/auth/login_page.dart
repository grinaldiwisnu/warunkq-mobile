import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthCubit authCubit;
  TextEditingController _emailInput = TextEditingController();
  TextEditingController _passwordInput = TextEditingController();
  bool _ableToNext = false;

  @override
  void initState() {
    authCubit = BlocProvider.of<AuthCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is AuthInitial) {
          LoadingDialog(
                  title: "Melakukan autentikasi ...",
                  description: "Mohon tunggu beberapa saat.")
              .show(context);
        } else if (state is AuthSuccessState) {
          Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        } else if (state is AuthFailedState) {
          Navigator.of(context).pop();
          AppAlertDialog(
                  title: "Autentikasi gagal",
                  description: state.message ?? '',
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () => Navigator.of(context).pop())
              .show(context);
        }
      },
      bloc: authCubit,
      child: BlocBuilder(
        bloc: authCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
                color: AppColor.black,
              ),
              backgroundColor: Colors.transparent,
            ),
            body: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25.h),
                        alignment: Alignment.center,
                        child: Text(
                          "Masukkan akun anda",
                          style: TextStyle(
                            color: AppColor.black,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: AddInput(
                          controller: _emailInput,
                          label: "Email",
                          type: TextInputType.emailAddress,
                          hint: "Masukkan email akun anda",
                          validation: (val) {
                            if (GlobalHelper.isEmpty(val)) {
                              return "Alamat email tidak boleh kosong";
                            } else if (!val!.contains("@")) {
                              return "Format email harus sesuai";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 25.w, vertical: 10.h),
                        child: AddInput(
                          controller: _passwordInput,
                          label: "Kata sandi",
                          hint: "Kata sandi akun anda",
                          passwordField: true,
                          onChanged: (val) {
                            setState(() {
                              _ableToNext = val.length >= 8;
                            });
                          },
                          validation: (val) {
                            if (GlobalHelper.isEmpty(val)) {
                              return "Kata sandi tidak boleh kosong";
                            } else if (val!.length < 8) {
                              return "Kata sandi harus lebih dari 8 karakter";
                            }

                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
              width: double.infinity,
              child: BaseButton(
                style: AppButtonStyle.primary,
                radius: 8,
                padding: 16,
                isDisabled: !_ableToNext,
                text: "Masuk",
                onPressed: () {
                  authCubit.auth(_emailInput.text, _passwordInput.text);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
