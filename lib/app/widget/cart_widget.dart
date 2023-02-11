import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/home.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:collection/collection.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: xWhite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Your Cart is Empyt",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              fillColor: xBlue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextTitle(
                  title: "Continue Shopping",
                  ls: 0,
                  fontwght: FontWeight.w500,
                  color: xWhite,
                  fontsz: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 60),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final product = cart.getItems[index];
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
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
                            Container(
                              height: 35,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: xBlue),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  product.qty == 1
                                      ? IconButton(
                                          onPressed: () {
                                            showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CupertinoActionSheet(
                                                title:
                                                    const Text('Remove Item '),
                                                message: const Text(
                                                    'Are you sure to remove this item'),
                                                actions: <
                                                    CupertinoActionSheetAction>[
                                                  CupertinoActionSheetAction(
                                                    isDefaultAction: true,
                                                    onPressed: () async {
                                                      context
                                                                  .read<
                                                                      WishListProvider>()
                                                                  .getWishItems
                                                                  .firstWhereOrNull((prod) =>
                                                                      prod.documentId ==
                                                                      product
                                                                          .documentId) !=
                                                              null
                                                          ? context
                                                              .read<
                                                                  CartProvider>()
                                                              .removeItem(
                                                                  product)
                                                          : context
                                                              .read<
                                                                  WishListProvider>()
                                                              .addWishItems(
                                                                product.name,
                                                                product.price,
                                                                1,
                                                                product.qtty,
                                                                product
                                                                    .imageUrl,
                                                                product
                                                                    .documentId,
                                                                product.suppId,
                                                              );
                                                      context
                                                          .read<CartProvider>()
                                                          .removeItem(product);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                        'Move to wishlist'),
                                                  ),
                                                  CupertinoActionSheetAction(
                                                    onPressed: () {
                                                      cart.removeItem(product);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                        'Delete Item'),
                                                  ),
                                                ],
                                                cancelButton: TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child:
                                                        const Text("Cancel")),
                                              ),
                                            );
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.trash,
                                            size: 16,
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            cart.reduceByOne(product);
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.minus,
                                            size: 16,
                                          ),
                                        ),
                                  product.qty == product.qtty
                                      ? TextTitle(
                                          title: product.qty.toString(),
                                          ls: 0,
                                          color: Colors.red,
                                          fontwght: FontWeight.bold,
                                          fontsz: 15)
                                      : TextTitle(
                                          title: product.qty.toString(),
                                          ls: 0,
                                          color: xWhite,
                                          fontwght: FontWeight.bold,
                                          fontsz: 15),
                                  IconButton(
                                      onPressed: product.qty == product.qtty
                                          ? () {
                                              MyMessengerHelper.showSnackBar(
                                                  scaffoldKey,
                                                  "Item Out of Stock");
                                            }
                                          : () {
                                              cart.increment(product);
                                            },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.plus,
                                        size: 16,
                                      )),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
