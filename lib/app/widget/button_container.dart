import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';

class ButtonContainer extends StatelessWidget {
  const ButtonContainer({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.kColors,
    required this.title,
    required this.ls,
    required this.fontwght,
    required this.fontsz,
    required this.bRadius,
    this.icons,
  });
  final double kWidth;
  final double kHeight;
  final Color kColors;
  final String title;
  final double ls;
  final FontWeight fontwght;
  final double fontsz;
  final double bRadius;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth,
      height: kHeight,
      decoration: BoxDecoration(
        color: kColors,
        borderRadius: BorderRadius.circular(
          bRadius,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextTitle(
            title: title,
            color: xWhite,
            ls: ls,
            textalign: TextAlign.center,
            fontwght: fontwght,
            fontsz: fontsz,
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: xWhite,
            size: 26,
          )
        ],
      ),
    );
  }
}

class TextTitle extends StatelessWidget {
  const TextTitle({
    super.key,
    required this.title,
    required this.ls,
    required this.fontwght,
    required this.fontsz,
    this.overflow,
    this.mL,
    this.textalign,
    this.color,
    this.decor,
  });
  final String title;
  final double ls;
  final FontWeight fontwght;
  final double fontsz;
  final TextOverflow? overflow;
  final int? mL;
  final TextAlign? textalign;
  final Color? color;
  final TextDecoration? decor;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: mL,
      textAlign: textalign,
      style: TextStyle(
        decoration: decor,
        color: color,
        letterSpacing: ls,
        fontWeight: fontwght,
        fontSize: fontsz,
        overflow: overflow,
      ),
    );
  }
}

class CostumText extends StatelessWidget {
  const CostumText(
      {super.key,
      required this.title,
      required this.ls,
      required this.fontwght,
      required this.fontsz});
  final String title;
  final double ls;
  final FontWeight fontwght;
  final double fontsz;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: xWhite,
        letterSpacing: ls,
        fontWeight: fontwght,
        fontSize: fontsz,
      ),
    );
  }
}

class ButtunContainers extends StatelessWidget {
  const ButtunContainers({
    super.key,
    required this.kWidth,
    required this.kHeight,
    required this.kColors,
    required this.title,
    required this.ls,
    required this.fontwght,
    required this.fontsz,
    required this.bRadius,
    this.icons,
  });
  final double kWidth;
  final double kHeight;
  final Color kColors;
  final String title;
  final double ls;
  final FontWeight fontwght;
  final double fontsz;
  final double bRadius;
  final IconData? icons;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kWidth,
      height: kHeight,
      decoration: BoxDecoration(
        color: kColors,
        borderRadius: BorderRadius.circular(
          bRadius,
        ),
      ),
      child: Row(
        children: [
          Center(
            child: CostumText(
              title: title,
              ls: ls,
              fontwght: fontwght,
              fontsz: fontsz,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Icon(
            icons,
            color: xWhite,
          )
        ],
      ),
    );
  }
}
