import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/product_detail.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';

class ProductCardModel extends StatelessWidget {
  const ProductCardModel({
    super.key,
    this.products,
  });
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(prodList: products),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 250,
                  ),
                  child: Image.network(
                    products['prodimage'][0],
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextTitle(
                  title: products['prodname'],
                  fontsz: 12,
                  fontwght: FontWeight.normal,
                  ls: 0,
                  overflow: TextOverflow.ellipsis,
                  mL: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("₹ ${products['price'].toStringAsFixed(2)}"),
                    products['sid'] == FirebaseAuth.instance.currentUser!.uid
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: xBlue,
                            ))
                        : IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.favorite_border_outlined,
                              color: xBlue,
                            ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
