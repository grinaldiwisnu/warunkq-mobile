import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/register.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/auth/auth_cubit.dart';
import 'package:warunkq_apps/presentation/views/auth/onboarding_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AuthCubit authCubit;
  TextEditingController _nameInput = TextEditingController();
  TextEditingController _phoneInput = TextEditingController();
  TextEditingController _storeNameInput = TextEditingController();
  TextEditingController _storeAddressInput = TextEditingController();
  TextEditingController _emailInput = TextEditingController();
  TextEditingController _passwordInput = TextEditingController();
  TextEditingController _rePasswordInput = TextEditingController();
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
              .push(MaterialPageRoute(builder: (context) => OnboardingPage()));
        } else if (state is RegisterFailedState) {
          Navigator.of(context).pop();
          AppAlertDialog(
                  title: "Registrasi gagal",
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
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          "Masukkan informasi akun anda",
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
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        child: AddInput(
                          controller: _nameInput,
                          label: "Nama lengkap",
                          hint: "Jono joni",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama lengkap tidak boleh kosong";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        child: AddInput(
                          controller: _emailInput,
                          label: "Email",
                          hint: "contoh@mail.com",
                          type: TextInputType.emailAddress,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Alamat email tidak boleh kosong";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        child: AddInput(
                          controller: _phoneInput,
                          label: "Nomor HP",
                          hint: "08XXXXXXXXX",
                          type: TextInputType.phone,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nomor HP tidak boleh kosong";
                            } else if (value!.length < 8) {
                              return "Nomor HP harus lebih dari 8 angka";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        child: AddInput(
                          controller: _storeNameInput,
                          label: "Nama warung",
                          hint: "Warung sejahtera",
                          type: TextInputType.name,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Nama warung tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        child: AddInput(
                          controller: _storeAddressInput,
                          label: "Alamat warung",
                          hint: "Jalan coklat no.1",
                          type: TextInputType.streetAddress,
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Alamat warung tidak boleh kosong";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
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
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Kata sandi tidak boleh kosong";
                            } else if (value!.length < 8) {
                              return "Katasandi harus lebih dari 8 angka";
                            }

                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 25.w,),
                        margin: EdgeInsets.only(bottom: 100.h),
                        child: AddInput(
                          controller: _rePasswordInput,
                          label: "Konfirmasi kata sandi",
                          hint: "Konfirmasi kata sandi akun anda",
                          passwordField: true,
                          onChanged: (val) {
                            setState(() {
                              _ableToNext = val.length >= 8;
                            });
                          },
                          validation: (value) {
                            if (GlobalHelper.isEmpty(value)) {
                              return "Kata sandi tidak boleh kosong";
                            } else if (value!.length < 8) {
                              return "Katasandi harus lebih dari 8 angka";
                            } else if (_passwordInput.text != _rePasswordInput.text) {
                              return "Password tidak sesuai dengan password sebelumnya";
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
                text: "Mendaftar",
                onPressed: () {
                  AppAlertDialog(
                      title: 'Konfirmasi pendaftaran',
                      description:
                      'Apakah data yang anda berikan sudah benar?',
                      positiveButtonText: 'Ya',
                      positiveButtonOnTap: () {
                        Register register = Register(
                          email: _emailInput.text,
                          fullname: _nameInput.text,
                          phone: _phoneInput.text,
                          password: _passwordInput.text,
                          storeName: _storeNameInput.text,
                          storeAddress: _storeAddressInput.text,
                          username: _nameInput.text.toLowerCase().replaceAll(" ", "").substring(0, 8),
                        );
                        authCubit.register(register);
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
