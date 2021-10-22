import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/presentation/views/home/home_page.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/phone_number_input.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneNumberInput = TextEditingController();
  TextEditingController _passwordInput = TextEditingController();
  bool _ableToNext = false;

  @override
  Widget build(BuildContext context) {
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
                  "Masukkan akun anda",
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
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                child: PhoneNumberInput(
                  controller: _phoneNumberInput,
                  onChanged: (String val) {
                    setState(() {
                      _ableToNext = val.length > 8;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                child: BaseInput(
                  controller: _passwordInput,
                  label: "Kata sandi akun anda",
                  passwordField: true,
                  maxLines: 1,
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
            fontSize: 16.sp,
            padding: 20,
            isDisabled: !_ableToNext,
            text: "Masuk",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        ));
  }
}
