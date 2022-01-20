import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  AuthCubit authCubit;
  TextEditingController _nameInput = TextEditingController();
  TextEditingController _phoneInput = TextEditingController();
  TextEditingController _storeNameInput = TextEditingController();
  TextEditingController _storeAddressInput = TextEditingController();
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
                  title: "Melakukan registrasi ...",
                  description: "Mohon tunggu beberapa saat.")
              .show(context);
        } else if (state is RegisterSuccessState) {
          Future.delayed(Duration(seconds: 2));
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomePage()));
        } else if (state is RegisterFailedState) {
          Navigator.of(context).pop();
          AppAlertDialog(
                  title: "Registrasi gagal",
                  description: state.message,
                  positiveButtonText: "Oke",
                  positiveButtonOnTap: () => Navigator.of(context).pop())
              .show(context);
        }
      },
      cubit: authCubit,
      child: BlocBuilder(
        cubit: authCubit,
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
            body: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25.h),
                    alignment: Alignment.center,
                    child: Text(
                      "Masukkan informasi akun anda",
                      style: TextStyle(
                        color: AppColor.black,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _emailInput,
                      label: "Nama lengkap",
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama lengkap tidak boleh kosong";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _emailInput,
                      label: "Email",
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Alamat email tidak boleh kosong";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _phoneInput,
                      label: "Nomor HP",
                      maxLines: 1,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nomor HP tidak boleh kosong";
                        } else if (value.length < 8) {
                          return "Nomor HP harus lebih dari 8 angka";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _passwordInput,
                      label: "Kata sandi akun anda",
                      passwordField: true,
                      maxLines: 1,
                      onChanged: (val) {
                        setState(() {
                          _ableToNext = val.length >= 8;
                        });
                      },
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Kata sandi tidak boleh kosong";
                        } else if (value.length < 8) {
                          return "Katasandi harus lebih dari 8 angka";
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _storeNameInput,
                      label: "Nama warung",
                      maxLines: 1,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama warung tidak boleh kosong";
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                    child: BaseInput(
                      controller: _storeAddressInput,
                      label: "Alamat warung",
                      maxLines: 1,
                      keyboardType: TextInputType.streetAddress,
                      validator: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Alamat warung tidak boleh kosong";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 25.w),
              width: double.infinity,
              child: BaseButton(
                style: AppButtonStyle.primary,
                radius: 8,
                padding: 20,
                isDisabled: !_ableToNext,
                text: "Mendaftar",
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
