import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/edit_product.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/utils/regex.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

import 'widget.dart';

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
                        Column(
                          children: [
                            FirstSectionPreviewPrevious(
                              hmediaSize: hmediaSize,
                              wmediaSize: wmediaSize,
                              items: items,
                              hsizedBox: hsizedBox,
                            ),
                            sizedBox20,
                            ExpandablePanel(
                              theme: const ExpandableThemeData(hasIcon: false),
                              header: Container(
                                width: 100,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: xBlue.withOpacity(0.2)),
                                child: const Center(
                                  child: TextTitle(
                                      title: "Change Images & Categories",
                                      color: xBlue,
                                      ls: 0,
                                      fontwght: FontWeight.bold,
                                      fontsz: 17),
                                ),
                              ),
                              collapsed: const SizedBox(
                                height: 20,
                              ),
                              expanded: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SecondSectionEditCategAndImg(
                                    hmediaSize: hmediaSize,
                                    wmediaSize: wmediaSize,
                                    hsizedBox: hsizedBox),
                              ),
                            ),
                          ],
                        ),
                        sizedBox20,
                        const Divider(
                          thickness: 1.3,
                          color: xBlack,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: wmediaSize * 0.45,
                              child: TextFormField(
                                  initialValue:
                                      items['price'].toStringAsFixed(2),
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
                                initialValue:
                                    items['discount'].toStringAsFixed(2),
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
                                initialValue:
                                    items['instock'].toStringAsFixed(0),
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
                            initialValue: items['prodname'],
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
                            initialValue: items['proddesc'],
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
                              : Column(
                                  children: [
                                    Row(
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
                                          onPressed: ePP.processing == true
                                              ? null
                                              : () {
                                                  ePP.saveChanges(
                                                      items,
                                                      context,
                                                      scaffoldKey,
                                                      form);
                                                },
                                          child: const TextTitle(
                                              title: "Save Changes",
                                              color: xWhite,
                                              ls: 0,
                                              fontwght: FontWeight.normal,
                                              fontsz: 16),
                                        ),
                                      ],
                                    ),
                                    sizedBox,
                                    SizedBox(
                                      width: double.infinity,
                                      child: RawMaterialButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        padding: const EdgeInsets.all(15),
                                        fillColor: xBlue,
                                        onPressed: () {
                                          ePP.deleteProduct(items, context);
                                        },
                                        child: const TextTitle(
                                            title: "Delete",
                                            color: xWhite,
                                            ls: 0,
                                            fontwght: FontWeight.normal,
                                            fontsz: 16),
                                      ),
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
