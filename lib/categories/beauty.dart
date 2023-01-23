import 'package:flutter/material.dart';
import 'package:siopa/utils/category_list.dart';
import 'package:siopa/widget/categ_widget.dart';

class BeautyCategory extends StatelessWidget {
  const BeautyCategory({super.key});

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
                const CategHeadLabel(catHeadLabel: "Beauty"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 60,
                    crossAxisSpacing: 5,
                    crossAxisCount: 3,
                    children: List.generate(beauty.length, (index) {
                      return SubCategModel(
                        mainCategName: "Beauty",
                        assetName: "images/beauty/beauty$index.jpg",
                        subCategLabel: beauty[index],
                        subCategName: beauty[index],
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
              title: "Beauty",
            ))
      ],
    );
  }
}
