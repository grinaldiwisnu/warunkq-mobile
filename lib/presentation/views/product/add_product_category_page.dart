import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:warunkq_apps/core/models/category.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class AddProductCategoryPage extends StatefulWidget {
  final Category? category;
  AddProductCategoryPage({Key? key, this.category}) : super(key: key);

  @override
  _AddProductCategoryPageState createState() => _AddProductCategoryPageState();
}

class _AddProductCategoryPageState extends State<AddProductCategoryPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String title = "Tambah Kategori";

  late CategoryCubit categoryCubit;
  TextEditingController categoryName = TextEditingController();
  TextEditingController? categoryDesc = TextEditingController();

  @override
  void initState() {
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    if (!GlobalHelper.isEmpty(widget.category)) {
      categoryName.text = widget.category!.name!;
      categoryDesc!.text = widget.category!.description!;
      title = "Ubah Kategori";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: BlocListener(
        bloc: categoryCubit,
        listener: (context, state) {
          if (state is CategoryLoading) {
            LoadingDialog(
                    title: "Loading ...",
                    description: "Sedang megirim ke sistem.")
                .show(context);
          } else if (state is AddCategoryFailed ||
              state is UpdateCategoryFailed) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Gagal!",
              description: "Gagal menyimpan kategori produk ke sistem.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                Navigator.of(context).pop();
              },
            ).show(context);
          } else if (state is AddCategorySuccess) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Berhasil!",
              description: "Berhasil menambahkan kategori produk.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                categoryCubit.load();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ).show(context);
          } else if (state is UpdateCategorySuccess) {
            Navigator.of(context).pop();
            AppAlertDialog(
              title: "Berhasil!",
              description: "Berhasil merubah kategori produk.",
              positiveButtonText: "Oke",
              positiveButtonOnTap: () {
                categoryCubit.load();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ).show(context);
          }
        },
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    AddInput(
                      label: "Nama kategori",
                      isRequired: true,
                      controller: categoryName,
                      hint: "e.g General",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama produk masih kosong";
                        }

                        return null;
                      },
                    ),
                    AddInput(
                      label: "Deskripsi Kategori",
                      controller: categoryDesc,
                      hint: "e.g 192381391293",
                      validation: (value) {
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: EdgeInsets.all(15),
        width: double.infinity,
        child: BaseButton(
          style: AppButtonStyle.primary,
          radius: 8,
          padding: 16,
          text: "Simpan Kategori",
          onPressed: () {
            Category category = Category(
              description: categoryDesc!.text,
              name: categoryName.text,
              id: GlobalHelper.isEmpty(widget.category)
                  ? 0
                  : widget.category!.id!,
            );

            if (!GlobalHelper.isEmpty(widget.category)) {
              categoryCubit.save(category);
            } else {
              categoryCubit.add(category);
            }
          },
        ),
      ),
    );
  }
}
