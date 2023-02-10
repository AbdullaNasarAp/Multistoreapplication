import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/full_screen.dart';
import 'package:siopa/app/utils/colors.dart';

class FullScreenViewOfProduct extends StatelessWidget {
  const FullScreenViewOfProduct({super.key, required this.imageList});
  final List<dynamic> imageList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: xBlue,
      ),
      body: SingleChildScrollView(
        child: Consumer<FullScreenProvider>(
          builder: (context, value, child) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: PageView(
                      children: List.generate(1, (index) {
                    return InteractiveViewer(
                        transformationController: TransformationController(),
                        child: Image.network(
                            imageList[value.selectedImage].toString()));
                  })),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(imageList.length, (index) {
                    return smallPreview(index, imageList[index], () {
                      value.taptap(index);
                    });
                  }),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget smallPreview(int index, String image2, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: Consumer<FullScreenProvider>(
        builder: (context, value, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            margin: const EdgeInsets.only(right: 15),
            padding: const EdgeInsets.all(8),
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.black
                      .withOpacity(value.selectedImage == index ? 1 : 0)),
            ),
            child: Image.network(
              image2,
              height: 100,
              width: 100,
            ),
          );
        },
      ),
    );
  }
}
