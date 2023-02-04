import 'package:flutter/material.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:siopa/app/widget/categ_widget.dart';

class BagCategory extends StatelessWidget {
  const BagCategory({super.key});

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
                const CategHeadLabel(catHeadLabel: "Bags"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 60,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: List.generate(bags.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: "Bags",
                        assetName: "images/bags/bags$index.jpg",
                        subCategLabel: bags[index + 1],
                        subCategName: bags[index + 1],
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
              title: "Bags",
            ))
      ],
    );
  }
}
