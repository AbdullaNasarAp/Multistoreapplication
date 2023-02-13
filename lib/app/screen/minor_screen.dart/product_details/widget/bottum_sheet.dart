import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/prod_detail.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/minor_screen.dart/visit_store.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';

class BottumSheet extends StatelessWidget {
  const BottumSheet({
    super.key,
    required this.prodList,
    required this.scaffoldKey,
  });

  final dynamic prodList;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(color: xBlue),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            VisitStore(supId: prodList['sid']),
                      ));
                    },
                    icon: const Icon(Icons.store)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CartScreen(
                          back: const AppBarbackButton(),
                        ),
                      ));
                    },
                    icon: Badge(
                        isLabelVisible:
                            context.read<CartProvider>().getItems.isEmpty
                                ? false
                                : true,
                        largeSize: 20,
                        label: Text(context
                            .watch<CartProvider>()
                            .getItems
                            .length
                            .toString()),
                        child: const Icon(Icons.shopping_cart))),
              ],
            ),
            Consumer<ProductDetailProvider>(
              builder: (context, pdp, child) {
                return MaterialButton(
                  color: Colors.black.withOpacity(0.2),
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  onPressed: () {
                    pdp.productToCart(context, scaffoldKey, prodList);
                  },
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: xWhite,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
