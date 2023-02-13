import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:collection/collection.dart';

class ProductDetailProvider with ChangeNotifier {
  void productToCart(
      BuildContext context, dynamic scaffoldKey, dynamic prodList) {
    if (prodList['instock'] == 0) {
      MyMessengerHelper.showSnackBar(scaffoldKey, "This Item is Out of stock");
    } else if (context.read<CartProvider>().getItems.firstWhereOrNull(
            (prod) => prod.documentId == prodList['productId']) !=
        null) {
      MyMessengerHelper.showSnackBar(scaffoldKey, "This Item already in Cart");
    } else {
      context.read<CartProvider>().addItems(
            prodList['prodname'],
            prodList['price'],
            1,
            prodList['instock'],
            prodList['prodimage'],
            prodList['productId'],
            prodList['sid'],
          );
    }
    notifyListeners();
  }

  void productToFavorite(BuildContext context, dynamic prodList) {
    context.read<WishListProvider>().getWishItems.firstWhereOrNull(
                (prod) => prod.documentId == prodList['productId']) !=
            null
        ? context.read<WishListProvider>().removeThis(prodList['productId'])
        : context.read<WishListProvider>().addWishItems(
              prodList['prodname'],
              prodList['price'],
              1,
              prodList['instock'],
              prodList['prodimage'],
              prodList['productId'],
              prodList['sid'],
            );
    notifyListeners();
  }
}
