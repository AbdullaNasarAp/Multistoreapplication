import 'package:flutter/material.dart';
import 'package:siopa/app/utils/category_list.dart';
import 'package:siopa/app/widget/categ_widget.dart';

class KidsCategory extends StatelessWidget {
  const KidsCategory({super.key});

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
                const CategHeadLabel(catHeadLabel: "Kids"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.68,
                  child: GridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 60,
                    crossAxisSpacing: 5,
                    crossAxisCount: 3,
                    children: List.generate(kids.length - 1, (index) {
                      return SubCategModel(
                        mainCategName: "Kids",
                        assetName: "images/kids/kids$index.jpg",
                        subCategLabel: kids[index + 1],
                        subCategName: kids[index + 1],
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
              title: "Kids",
            ))
      ],
    );
  }
}
