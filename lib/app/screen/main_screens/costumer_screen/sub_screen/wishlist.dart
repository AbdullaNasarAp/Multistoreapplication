import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/sub_screen/profile/widget/alert.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/wishlist_widget.dart';

class Wishlist extends StatelessWidget {
  Wishlist({
    super.key,
  });

  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
          backgroundColor: xWhite,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: xBlue,
            title: const AppBarTitle(title: "Wishlist"),
            leading: const AppBarbackButton(),
            iconTheme: const IconThemeData(color: xWhite),
            actions: [
              context.watch<CartProvider>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        Alert(
                          title: "Clear Whishlist",
                          content: "Are you sure to clear wishlist",
                          onpress: () {
                            context.read<WishListProvider>().clearIWishtems();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: xWhite,
                      ),
                    )
            ],
          ),
          body: context.watch<WishListProvider>().getWishItems.isNotEmpty
              ? WishlistItem(scaffoldKey: scaffoldKey)
              : const EmptyWidget()),
    );
  }
}
