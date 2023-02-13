import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:collection/collection.dart';

class WishListModel extends StatelessWidget {
  const WishListModel({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(
      builder: (context, wishlist, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 150,
            child: Card(
              elevation: 2,
              shadowColor: Colors.blue,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.network(product.imageUrl.first,
                        fit: BoxFit.cover, height: 150, width: 100),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitle(
                            title: product.name,
                            ls: 0,
                            mL: 2,
                            fontwght: FontWeight.w800,
                            overflow: TextOverflow.ellipsis,
                            fontsz: 16),
                        TextTitle(
                            title: product.price.toStringAsFixed(1),
                            ls: 0,
                            mL: 2,
                            fontwght: FontWeight.w600,
                            color: Colors.red,
                            overflow: TextOverflow.ellipsis,
                            fontsz: 17),
                        Row(
                          children: [
                            Container(
                              height: 35,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: xBlue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: IconButton(
                                  onPressed: () {
                                    wishlist.removeWishItem(product);
                                  },
                                  icon: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    size: 18,
                                  )),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            context
                                            .watch<CartProvider>()
                                            .getItems
                                            .firstWhereOrNull((prod) =>
                                                prod.documentId ==
                                                product.documentId) !=
                                        null ||
                                    product.qtty == 0
                                ? const SizedBox()
                                : Container(
                                    height: 35,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: xBlue,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: IconButton(
                                        onPressed: () {
                                          context.read<CartProvider>().addItems(
                                                product.name,
                                                product.price,
                                                1,
                                                product.qtty,
                                                product.imageUrl,
                                                product.documentId,
                                                product.suppId,
                                              );
                                        },
                                        icon: const FaIcon(
                                          FontAwesomeIcons.cartPlus,
                                          size: 18,
                                        )),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
