import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/product_detail.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import '../../../controller/costumer_control/wishlist.dart';
import 'package:collection/collection.dart';

import '../../minor_screen.dart/edit_prod/edit_product.dart';

class ProductCardModel extends StatelessWidget {
  const ProductCardModel({
    super.key,
    this.products,
  });
  final dynamic products;

  @override
  Widget build(BuildContext context) {
    var onSale = products['discount'];
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(prodList: products),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10)),
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("₹"),
                        onSale == 0
                            ? TextTitle(
                                title: products['price'].toStringAsFixed(0),
                                ls: 0,
                                color: xBlack87,
                                fontwght: FontWeight.normal,
                                fontsz: 11)
                            : TextTitle(
                                title: products['price'].toStringAsFixed(0),
                                ls: 0,
                                color: xGrey,
                                decor: TextDecoration.lineThrough,
                                fontwght: FontWeight.normal,
                                fontsz: 11),
                        onSale == 0
                            ? const Text("")
                            : TextTitle(
                                title:
                                    ((1 - (onSale / 100)) * products['price'])
                                        .toStringAsFixed(1),
                                ls: 0,
                                color: xBlack87,
                                fontwght: FontWeight.normal,
                                fontsz: 13),
                        products['sid'] ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        EditProduct(items: products),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: xBlue,
                                ))
                            : IconButton(
                                onPressed: () {
                                  context
                                              .read<WishListProvider>()
                                              .getWishItems
                                              .firstWhereOrNull((prod) =>
                                                  prod.documentId ==
                                                  products['productId']) !=
                                          null
                                      ? context
                                          .read<WishListProvider>()
                                          .removeThis(products['productId'])
                                      : context
                                          .read<WishListProvider>()
                                          .addWishItems(
                                            products['prodname'],
                                            products['price'],
                                            1,
                                            products['instock'],
                                            products['prodimage'],
                                            products['productId'],
                                            products['sid'],
                                          );
                                },
                                icon: context
                                            .watch<WishListProvider>()
                                            .getWishItems
                                            .firstWhereOrNull((prod) =>
                                                prod.documentId ==
                                                products['productId']) !=
                                        null
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.favorite_outline_rounded,
                                        color: Colors.red,
                                        size: 20,
                                      )),
                      ],
                    )
                  ],
                ),
              ),
            ),
            onSale == 0
                ? const SizedBox()
                : Positioned(
                    right: 0,
                    top: 20,
                    child: Container(
                      height: 30,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(
                            20,
                          ))),
                      child: Center(
                        child: TextTitle(
                            title: "$onSale% OFF",
                            ls: 0,
                            fontwght: FontWeight.normal,
                            fontsz: 13),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
