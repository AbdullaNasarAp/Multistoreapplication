import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/edit_product.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class EditProduct extends StatelessWidget {
  EditProduct({super.key, this.items});
  final dynamic items;

  final GlobalKey<FormState> form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    var hmediaSize = MediaQuery.of(context).size.height;
    var wmediaSize = MediaQuery.of(context).size.width;

    var inputDecoration = InputDecoration(
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        contentPadding: const EdgeInsets.all(20),
        alignLabelWithHint: true,
        labelStyle: const TextStyle(color: xWhite),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xBlue),
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2, color: xGreen),
          borderRadius: BorderRadius.circular(25),
        ));
    const wsizedBox = SizedBox(
      width: 20,
    );
    const hsizedBox = SizedBox(
      height: 20,
    );
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        backgroundColor: xWhite,
        appBar: AppBar(
          title: const AppBarTitle(title: "Edit Products"),
        ),
        body: Container(
          color: xWhite,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: form,
                child: Consumer<EditProductProvider>(
                  builder: (context, ePP, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                  color: xBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: hmediaSize * 0.25,
                                width: wmediaSize * 0.45,
                                child: ePP.previewCurrentImages(items)),
                            Column(
                              children: [
                                const TextTitle(
                                    title: "Main Category",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 13),
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: xBlue.withOpacity(0.2)),
                                  child:
                                      Center(child: Text(items['maincateg'])),
                                ),
                                hsizedBox,
                                const TextTitle(
                                    title: "Sub Category",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 13),
                                Container(
                                  width: 100,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: xBlue.withOpacity(0.2)),
                                  child: Center(child: Text(items['subcateg'])),
                                ),
                              ],
                            )
                          ],
                        ),
                        sizedBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: xBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: hmediaSize * 0.25,
                              width: wmediaSize * 0.45,
                              child: ePP.imgFileList != null
                                  ? ePP.previewImages()
                                  : const Center(
                                      child: Text(
                                        "       you haven't\n picked images yet !",
                                        style: TextStyle(color: xWhite),
                                      ),
                                    ),
                            ),
                            Column(
                              children: [
                                const TextTitle(
                                    title: "Select main Category",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 13),
                                DropdownButton(
                                  alignment: Alignment.centerLeft,
                                  menuMaxHeight: 150,
                                  value: ePP.mainCategoryValue,
                                  focusColor: xBlue,
                                  dropdownColor: xWhite,
                                  items: maincateg
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: TextTitle(
                                          title: value,
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 13),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    ePP.selectMainCateg(value);
                                  },
                                ),
                                hsizedBox,
                                const TextTitle(
                                    title: "Select subCategory",
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 13),
                                DropdownButton(
                                  alignment: Alignment.centerLeft,
                                  menuMaxHeight: 150,
                                  disabledHint: const Text("Select Category"),
                                  value: ePP.subCategoryValue,
                                  focusColor: xBlue,
                                  dropdownColor: xWhite,
                                  items: ePP.subCategoryList
                                      .map<DropdownMenuItem<String>>((value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: TextTitle(
                                          title: value,
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 13),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    ePP.subcategValueset(value);
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1.3,
                          color: xBlack,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: wmediaSize * 0.45,
                              child: TextFormField(
                                  style: const TextStyle(color: xBlack87),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter the Price";
                                    } else if (value.isValidPrice() != true) {
                                      return "Enter a valid Price";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    ePP.proPrice = double.parse(newValue!);
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration: inputDecoration.copyWith(
                                      labelStyle:
                                          const TextStyle(color: xBlack87),
                                      labelText: 'Price',
                                      hintText: "ProductPrice")),
                            ),
                            wsizedBox,
                          ],
                        ),
                        hsizedBox,
                        Row(
                          children: [
                            SizedBox(
                              width: wmediaSize * 0.45,
                              child: TextFormField(
                                maxLength: 2,
                                style: const TextStyle(color: xBlack87),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return null;
                                  } else if (value.isValidDiscount() != true) {
                                    return "Enter valid discount";
                                  }
                                  return null;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                onSaved: (newValue) {
                                  ePP.discount = int.parse(newValue!);
                                },
                                decoration: inputDecoration.copyWith(
                                    labelText: 'Discount',
                                    labelStyle:
                                        const TextStyle(color: xBlack87),
                                    hintText: "Product Discount"),
                              ),
                            ),
                            wsizedBox,
                            SizedBox(
                              width: wmediaSize * 0.45,
                              child: TextFormField(
                                style: const TextStyle(color: xBlack87),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter the Quantity";
                                  } else if (value.isValidQuantity() != true) {
                                    return "Enter valid quantity";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  ePP.quantity = int.parse(newValue!);
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.number,
                                decoration: inputDecoration.copyWith(
                                    labelText: 'Quantity',
                                    labelStyle:
                                        const TextStyle(color: xBlack87),
                                    hintText: "Enter the Quantity"),
                              ),
                            ),
                          ],
                        ),
                        hsizedBox,
                        SizedBox(
                          width: wmediaSize * 100,
                          child: TextFormField(
                            style: const TextStyle(color: xBlack87),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Product Name";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              ePP.proName = value!;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLength: 100,
                            maxLines: 3,
                            keyboardType: TextInputType.name,
                            decoration: inputDecoration.copyWith(
                                alignLabelWithHint: true,
                                labelText: 'Product Name',
                                labelStyle: const TextStyle(color: xBlack87),
                                hintText: "Enter Product Name"),
                          ),
                        ),
                        hsizedBox,
                        SizedBox(
                          width: wmediaSize * 100,
                          child: TextFormField(
                            style: const TextStyle(color: xBlack87),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter the Product Description";
                              }
                              return null;
                            },
                            onSaved: (value) {
                              ePP.proDesc = value!;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            maxLength: 1000,
                            maxLines: 7,
                            keyboardType: TextInputType.name,
                            decoration: inputDecoration.copyWith(
                                alignLabelWithHint: true,
                                labelText: 'Product Description',
                                labelStyle: const TextStyle(color: xBlack87),
                                hintText: "Enter Product Description"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ePP.processing == true
                              ? const Center(child: CircularProgressIndicator())
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: const EdgeInsets.all(15),
                                      fillColor: xBlue,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const TextTitle(
                                          title: "Cancel",
                                          color: xWhite,
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 16),
                                    ),
                                    RawMaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: const EdgeInsets.all(15),
                                      fillColor: xBlue,
                                      onPressed:
                                          ePP.processing == true ? null : () {},
                                      child: const TextTitle(
                                          title: "Save Changes",
                                          color: xWhite,
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 16),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
