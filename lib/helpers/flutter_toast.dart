import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showFlutterToast(String message,
    {ToastGravity position = ToastGravity.BOTTOM}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      backgroundColor: Colors.grey,
      gravity: position,
      fontSize: 14.0);
}
