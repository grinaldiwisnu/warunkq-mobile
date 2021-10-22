import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/app_color.dart';

class ProductCard extends StatelessWidget {
  final String productInitial, productStock, productName, productPrice;
  final bool isBestSeller;
  final Function onTap;
  const ProductCard(
      {Key key,
      @required this.productInitial,
      @required this.productName,
      @required this.productPrice,
      @required this.productStock,
      @required this.isBestSeller,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 15.0 / 10.0,
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: AppColor.darkGrey,
                      child: Text(
                        this.productInitial,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      padding: EdgeInsets.all(4),
                      child: Text(this.productStock,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    Positioned(
                      child: new Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 5.0.h),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 5.0.w),
                            height: 23,
                            child: Opacity(
                                opacity: 1,
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Terlaris",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: AppColor.greenSecondary,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD6FFDE),
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                ))),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        this.productName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Rp" + this.productPrice,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
