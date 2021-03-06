import 'package:flutter/material.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final Function(String)? onChanged;

  SearchBar(
      {Key? key,
      @required this.controller,
      @required this.label,
      @required this.onChanged})
      : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
      ),
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: InputDecoration(
          fillColor: AppColor.grey,
          focusColor: AppColor.grey,
          hoverColor: AppColor.grey,
          filled: true,
          prefixIcon: Container(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Container(
              child: Icon(
                Icons.search_rounded,
                color: AppColor.disableDarkGrey,
                size: 18.sp,
              ),
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          hintText: widget.label,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.disableDarkGrey,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.grey, width: 1.5)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColor.grey, width: 1.5))),
    );
  }
}
