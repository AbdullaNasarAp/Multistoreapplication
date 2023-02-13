import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';

class ProductDetailHeader extends StatelessWidget {
  const ProductDetailHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: xGrey,
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: xBlue, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: xGrey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
