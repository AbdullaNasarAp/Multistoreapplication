import 'package:flutter/material.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:siopa/app/widget/categ_widget.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CategHeadLabel(catHeadLabel: "Accessories"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 60,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: List.generate(accessories.length, (index) {
                      return SubCategModel(
                        mainCategName: "Accessories",
                        assetName: "images/accessories/accessories$index.jpg",
                        subCategLabel: accessories[index],
                        subCategName: accessories[index],
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
        const Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(
              title: "Accessories",
            ))
      ],
    );
  }
}
