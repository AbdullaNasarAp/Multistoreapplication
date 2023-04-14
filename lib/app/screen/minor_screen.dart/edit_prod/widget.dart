import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controller/supplier_control/edit_product.dart';
import '../../../utils/category_list.dart';
import '../../../utils/colors.dart';
import '../../../widget/button_container.dart';

class FirstSectionPreviewPrevious extends StatelessWidget {
  const FirstSectionPreviewPrevious({
    super.key,
    required this.hmediaSize,
    required this.wmediaSize,
    required this.items,
    required this.hsizedBox,
  });

  final double hmediaSize;
  final double wmediaSize;
  final dynamic items;
  final SizedBox hsizedBox;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<EditProductProvider>(
          builder: (context, ePP, child) {
            return Container(
                decoration: BoxDecoration(
                  color: xBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: hmediaSize * 0.25,
                width: wmediaSize * 0.45,
                child: ePP.previewCurrentImages(items));
          },
        ),
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
              child: Center(child: Text(items['maincateg'])),
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
    );
  }
}

class SecondSectionEditCategAndImg extends StatelessWidget {
  const SecondSectionEditCategAndImg({
    super.key,
    required this.hmediaSize,
    required this.wmediaSize,
    required this.hsizedBox,
  });

  final double hmediaSize;
  final double wmediaSize;
  final SizedBox hsizedBox;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditProductProvider>(
      builder: (context, ePP, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                      items: maincateg.map<DropdownMenuItem<String>>((value) {
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
            sizedBox20,
            ePP.imgFileList!.isEmpty
                ? RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(15),
                    fillColor: xBlue,
                    onPressed: () {
                      ePP.pickProductImage();
                    },
                    child: const TextTitle(
                        title: "Select Image",
                        ls: 0,
                        color: xWhite,
                        fontwght: FontWeight.normal,
                        fontsz: 16),
                  )
                : RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(15),
                    fillColor: xBlue,
                    onPressed: () {
                      ePP.emptyImageList();
                    },
                    child: const TextTitle(
                        title: "Delete Image",
                        ls: 0,
                        fontwght: FontWeight.normal,
                        fontsz: 16),
                  )
          ],
        );
      },
    );
  }
}
