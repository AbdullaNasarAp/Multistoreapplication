import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/wishlist_model.dart';

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
          children: const [
            Text(
              "Your Wishlist is Empyt",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class WishlistItem extends StatelessWidget {
  const WishlistItem({
    super.key,
    required this.scaffoldKey,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<WishListProvider>(
      builder: (context, wishlist, child) {
        return ListView.builder(
          itemCount: wishlist.count,
          itemBuilder: (context, index) {
            final product = wishlist.getWishItems[index];
            return WishListModel(product: product);
          },
        );
      },
    );
  }
}
