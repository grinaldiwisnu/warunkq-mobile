import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';

class ProductCard extends StatelessWidget {
  final Product? data;
  final bool? isBestSeller;
  final VoidCallback? onTap;

  const ProductCard(
      {Key? key,
      @required this.data,
      @required this.isBestSeller,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        elevation: 0.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 15.0 / 10.0,
              child: Container(
                child: Stack(
                  children: [
                    GlobalHelper.isEmpty(data!.image)
                        ? Container(
                            alignment: Alignment.center,
                            color: AppColor.darkGrey,
                            child: Text(
                              GlobalHelper.getInitials(this.data!.productName),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            alignment: Alignment.center,
                            color: AppColor.darkGrey,
                            child: CachedNetworkImage(
                              imageUrl: data!.image!,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(
                                      value: progress.progress,
                                    ),
                                  )
                                ],
                              ),
                              errorWidget: (context, url, error) => Container(
                                alignment: Alignment.center,
                                color: AppColor.darkGrey,
                                child: Text(
                                  GlobalHelper.getInitials(
                                      this.data!.productName),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              height: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Text(this.data!.quantity.toString(),
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center),
                      decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    isBestSeller!
                        ? Positioned(
                            child: new Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 5.0.h),
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 5.0.w),
                                  height: 23.h,
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
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                        ),
                                      ))),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data!.productName!,
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
                        "Rp" + GlobalHelper.formatPrice(data!.price),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16.sp,
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

  Widget overlayActiveItem(double count) {
    return Stack(
      children: <Widget>[
        SizedBox(
          child: Opacity(
            opacity: 0.5,
            child: Container(color: AppColor.boxGrey),
          ),
        ),
        Center(
          child: Opacity(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: AppColor.disableGrey),
              padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
              child: Text(
                count.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColor.grey),
                textAlign: TextAlign.center,
              ),
            ),
            opacity: 0.7,
          ),
        ),
      ],
    );
  }
}
