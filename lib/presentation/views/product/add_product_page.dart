import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:warunkq_apps/core/models/product.dart';
import 'package:warunkq_apps/helpers/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:warunkq_apps/helpers/global_helper.dart';
import 'package:warunkq_apps/presentation/cubit/category/category_cubit.dart';
import 'package:warunkq_apps/presentation/cubit/product/product_cubit.dart';
import 'package:warunkq_apps/presentation/widgets/base/base_button.dart';
import 'package:warunkq_apps/presentation/widgets/components/add_input.dart';
import 'package:warunkq_apps/presentation/widgets/components/app_alert_dialog.dart';
import 'package:warunkq_apps/presentation/widgets/components/loading_dialog.dart';

class AddProductPage extends StatefulWidget {
  final Product? product;

  AddProductPage({Key? key, this.product}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  ImagePicker _picker = ImagePicker();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String title = "Tambah Produk";
  late ProductCubit productCubit;
  late CategoryCubit categoryCubit;
  int? selectedCategory;
  TextEditingController productName = TextEditingController();
  TextEditingController productSKU = TextEditingController();
  TextEditingController productHPP = TextEditingController();
  TextEditingController productHJP = TextEditingController();
  TextEditingController productStock = TextEditingController();
  File images = File("");

  @override
  void initState() {
    productCubit = BlocProvider.of<ProductCubit>(context);
    categoryCubit = BlocProvider.of<CategoryCubit>(context);
    if (!GlobalHelper.isEmpty(widget.product)) {
      productName.text = widget.product!.productName!;
      productHPP.text = widget.product!.basePrice.toString();
      productHJP.text = widget.product!.price.toString();
      productStock.text = widget.product!.quantity.toString();
      productSKU.text = widget.product!.description!;
      selectedCategory = widget.product!.categoryId;
      title = "Ubah Produk";
    }
    categoryCubit.load();
    super.initState();
  }

  _imgFromCamera() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      setState(() {
        images = File(image.path);
      });
    }
  }

  _imgFromGallery() async {
    XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      setState(() {
        images = File(image.path);
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text(
                        'Gallery',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text(
                      'Camera',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      listener: (context, state) {
        if (state is ProductLoading) {
          LoadingDialog(
                  title: "Loading ...",
                  description: "Sedang megirim ke sistem.")
              .show(context);
        } else if (state is AddProductFailed || state is UpdateProductFailed) {
          Navigator.of(context).pop();
          AppAlertDialog(
            title: "Gagal!",
            description: "Gagal menyimpan produk ke sistem.",
            positiveButtonText: "Oke",
            positiveButtonOnTap: () {
              Navigator.of(context).pop();
            },
          ).show(context);
        } else if (state is AddProductSuccess) {
          Navigator.of(context).pop();
          AppAlertDialog(
            title: "Berhasil!",
            description: "Berhasil menambahkan produk.",
            positiveButtonText: "Oke",
            positiveButtonOnTap: () {
              Navigator.of(context).pop();
              productCubit.load();
              Navigator.of(context).pop();
            },
          ).show(context);
        } else if (state is UpdateProductSuccess) {
          Navigator.of(context).pop();
          AppAlertDialog(
            title: "Berhasil!",
            description: "Berhasil merubah produk.",
            positiveButtonText: "Oke",
            positiveButtonOnTap: () {
              Navigator.of(context).pop();
              productCubit.load();
              Navigator.of(context).pop();
            },
          ).show(context);
        }
      },
      bloc: productCubit,
      child: Scaffold(
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
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 220,
                          height: 120,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColor.boxGrey,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: images.path != ""
                              ? Image.file(
                                  images,
                                  width:
                                      MediaQuery.of(context).size.width - 220,
                                  height: 120,
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      size: 36.sp,
                                      color: AppColor.darkGrey,
                                    ),
                                    Text(
                                      "Tambahkan gambar produk",
                                      style: TextStyle(
                                        color: AppColor.darkGrey,
                                        fontSize: 12.sp,
                                      ),
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    AddInput(
                      label: "Nama produk",
                      isRequired: true,
                      controller: productName,
                      hint: "e.g Minyak goreng",
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Nama produk masih kosong";
                        }

                        return null;
                      },
                    ),
                    AddInput(
                      label: "SKU",
                      controller: productSKU,
                      hint: "e.g 192381391293",
                      type: TextInputType.number,
                      validation: (value) {
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AddInput(
                            label: "Harga pokok produk",
                            isRequired: true,
                            controller: productHPP,
                            hint: "e.g 5000",
                            type: TextInputType.number,
                            validation: (value) {
                              if (GlobalHelper.isEmpty(value)) {
                                return "Harga pokok produk masih kosong";
                              }

                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Expanded(
                          child: AddInput(
                            label: "Harga jual produk",
                            isRequired: true,
                            controller: productHJP,
                            hint: "e.g 6000",
                            type: TextInputType.number,
                            validation: (value) {
                              if (GlobalHelper.isEmpty(value)) {
                                return "Harga jual produk masih kosong";
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    AddInput(
                      label: "Stok produk",
                      hint: "e.g 50",
                      controller: productStock,
                      isRequired: true,
                      type: TextInputType.number,
                      validation: (value) {
                        if (GlobalHelper.isEmpty(value)) {
                          return "Stok produk masih kosong";
                        }

                        return null;
                      },
                    ),
                    BlocBuilder(
                      bloc: categoryCubit,
                      builder: (context, state) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5.h),
                                child: Row(
                                  children: [
                                    Text(
                                      "Kategori produk",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.normal,
                                        color: AppColor.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              DropdownButtonFormField(
                                items: List.generate(
                                    categoryCubit.listCategory.length,
                                    (index) => DropdownMenuItem(
                                          child: Text(categoryCubit
                                              .listCategory[index].name!),
                                          value: categoryCubit
                                              .listCategory[index].id!,
                                        )),
                                style: TextStyle(
                                  color: AppColor.black,
                                  fontSize: 16.sp,
                                ),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.boxGrey),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColor.primary),
                                  ),
                                  isDense: true,
                                ),
                                isDense: true,
                                isExpanded: true,
                                onChanged: (int? val) {
                                  setState(() {
                                    selectedCategory = val!;
                                  });
                                },
                                elevation: 1,
                                value: selectedCategory,
                                validator: (value) {
                                  if (GlobalHelper.isEmpty(value)) {
                                    return "Kategori produk harus dipilih";
                                  }

                                  return null;
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
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
            text: "Simpan Produk",
            onPressed: () {
              Product product = Product(
                quantity: GlobalHelper.formatStringToNumber(productStock.text),
                basePrice: GlobalHelper.formatStringToNumber(productHPP.text),
                categoryId: selectedCategory,
                description: productSKU.text,
                id: GlobalHelper.isEmpty(widget.product)
                    ? 0
                    : widget.product?.id!,
                price: GlobalHelper.formatStringToNumber(productHJP.text),
                productName: productName.text,
                uploadImage: GlobalHelper.isEmpty(images.path) ? null : images,
              );
              if (!GlobalHelper.isEmpty(widget.product)) {
                productCubit.save(product);
              } else {
                productCubit.add(product);
              }
            },
          ),
        ),
      ),
    );
  }
}
