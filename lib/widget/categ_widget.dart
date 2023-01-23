import 'package:flutter/material.dart';
import 'package:siopa/minor_screen.dart/subcategory.dart';

class SliderBar extends StatelessWidget {
  const SliderBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.brown.withOpacity(0.2),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("<<", style: textStyle),
                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                        letterSpacing: 10,
                        fontSize: 16,
                        color: Colors.brown,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    ">>",
                    style: textStyle,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const textStyle = TextStyle(
    letterSpacing: 10,
    fontSize: 16,
    color: Colors.brown,
    fontWeight: FontWeight.w600);

class SubCategModel extends StatelessWidget {
  const SubCategModel({
    Key? key,
    required this.mainCategName,
    required this.subCategName,
    required this.assetName,
    required this.subCategLabel,
  }) : super(key: key);
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubCategory(
              subcategoryName: subCategName, mainCategory: mainCategName),
        ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: 60,
            child: Image(
              fit: BoxFit.contain,
              image: AssetImage(assetName),
            ),
          ),
          Text(
            subCategLabel,
            textAlign: TextAlign.justify,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}

class CategHeadLabel extends StatelessWidget {
  const CategHeadLabel({
    Key? key,
    required this.catHeadLabel,
  }) : super(key: key);
  final String catHeadLabel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        catHeadLabel,
        style: const TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}
