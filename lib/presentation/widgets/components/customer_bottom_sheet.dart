import 'package:flutter/material.dart';
import 'package:warunkq_apps/presentation/cubit/cashier/cashier_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomerBottomSheet {
  final TextEditingController controller = TextEditingController();
  final CashierCubit cashierCubit;

  CustomerBottomSheet(this.cashierCubit);

  void show(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  right: 15.w,
                  left: 15.w,
                  top: 15.h,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            bottom: 10.h, left: 15.w, right: 15.w),
                        child: Text(
                          "Kirim Struk Belanja",
                          style: TextStyle(
                              fontSize: 16.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close)),
                      )
                    ],
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(bottom: 10.h, left: 15.w, right: 15.w),
                    child: AddInput(
                      label: "Nomor HP",
                      controller: controller,
                      hint: "e.g 192381391293",
                      type: TextInputType.number,
                      validation: (value) {
                        return null;
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    width: double.infinity,
                    child: BaseButton(
                      style: AppButtonStyle.primary,
                      radius: 8,
                      padding: 16,
                      text: "Kirim Struk",
                      onPressed: () {
                        cashierCubit.sendReceipt(cashierCubit.cartCashier,
                            controller.text);
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ));
  }
}
