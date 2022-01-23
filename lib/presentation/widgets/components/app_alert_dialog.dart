import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAlertDialog {
  final String? title, description, positiveButtonText, negativeButtonText;
  final VoidCallback? positiveButtonOnTap, negativeButtonOnTap;

  AppAlertDialog(
      {@required this.title,
      @required this.description,
      this.positiveButtonText,
      this.positiveButtonOnTap,
      this.negativeButtonText,
      this.negativeButtonOnTap});

  void show(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              title!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600),
            ),
            content: Text(
              description!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
            actions: <Widget>[
              negativeButtonText != null && negativeButtonOnTap != null
                  ? FlatButton(
                      child: Text(negativeButtonText!),
                      onPressed: negativeButtonOnTap,
                    )
                  : Container(),
              positiveButtonText != null && positiveButtonOnTap != null
                  ? FlatButton(
                      child: Text(positiveButtonText!),
                      onPressed: positiveButtonOnTap,
                    )
                  : Container(),
            ],
          );
        });
  }
}
