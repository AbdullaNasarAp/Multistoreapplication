import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/cart.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/auth/widgets.dart';
import 'package:siopa/app/screen/main_screens/costumer_screen/cart.dart';
import 'package:siopa/app/screen/main_screens/widget/product_card_model.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/full_screen_preview.dart';
import 'package:siopa/app/screen/minor_screen.dart/visit_store.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:collection/collection.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, this.prodList});
  final dynamic prodList;
  late List<dynamic> imageList = prodList['prodimage'];

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: prodList['maincateg'])
        .where('subcateg', isEqualTo: prodList['subcateg'])
        .snapshots();
    const sizedBox = SizedBox(
      height: 10,
    );
    const sizedBox20 = SizedBox(
      height: 20,
    );
    const sizedBox30 = SizedBox(
      height: 30,
    );

    final GlobalKey<ScaffoldMessengerState> scaffoldKey =
        GlobalKey<ScaffoldMessengerState>();

    return Material(
      child: ScaffoldMessenger(
        key: scaffoldKey,
        child: Scaffold(
          backgroundColor: xWhite,
          appBar: AppBar(
            backgroundColor: xBlue,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(color: xBlue.withOpacity(0.1)),
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                              pagination: const SwiperPagination(
                                  builder: SwiperPagination.dots),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          FullScreenViewOfProduct(
                                              imageList: imageList),
                                    ));
                                  },
                                  child: Image.network(
                                    imageList[index],
                                    fit: BoxFit.fitHeight,
                                  ),
                                );
                              },
                              itemCount: imageList.length),
                        ),
                        Positioned(
                          right: 0,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: xBlue,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        color: xWhite,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: xBlue,
                                  child: IconButton(
                                      onPressed: () {
                                        context
                                                    .read<WishListProvider>()
                                                    .getWishItems
                                                    .firstWhereOrNull((prod) =>
                                                        prod.documentId ==
                                                        prodList[
                                                            'productId']) !=
                                                null
                                            ? context
                                                .read<WishListProvider>()
                                                .removeThis(
                                                    prodList['productId'])
                                            : context
                                                .read<WishListProvider>()
                                                .addWishItems(
                                                  prodList['prodname'],
                                                  prodList['price'],
                                                  1,
                                                  prodList['instock'],
                                                  prodList['prodimage'],
                                                  prodList['productId'],
                                                  prodList['sid'],
                                                );
                                      },
                                      icon: context
                                                  .watch<WishListProvider>()
                                                  .getWishItems
                                                  .firstWhereOrNull((prod) =>
                                                      prod.documentId ==
                                                      prodList['productId']) !=
                                              null
                                          ? const Icon(
                                              Icons.favorite,
                                              color: xWhite,
                                            )
                                          : const Icon(
                                              Icons.favorite_outline_rounded,
                                              color: xWhite,
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          sizedBox,
                          TextTitle(
                              title: prodList['prodname'],
                              ls: 0,
                              fontwght: FontWeight.bold,
                              fontsz: 20),
                          sizedBox,
                          Container(
                            width: 80,
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.elliptical(50, 50)),
                              color: xGreen,
                            ),
                            child: const Center(
                              child: TextTitle(
                                  title: "Hot Deal",
                                  ls: 0,
                                  fontwght: FontWeight.normal,
                                  fontsz: 15),
                            ),
                          ),
                          sizedBox,
                          TextTitle(
                              title: "MRP ${prodList['price'].toString()}",
                              ls: 0,
                              color: Colors.red,
                              fontwght: FontWeight.bold,
                              fontsz: 20),
                          sizedBox,
                          TextTitle(
                              title:
                                  "${prodList['instock'].toString()} Pieces avalailable on stock",
                              color: prodList['instock'] > 20
                                  ? Colors.green
                                  : Colors.red,
                              ls: 0,
                              fontwght: FontWeight.normal,
                              fontsz: 16),
                          sizedBox,
                          Row(
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.orangeAccent,
                              ),
                              Icon(
                                Icons.star_border,
                                color: Colors.orangeAccent,
                              ),
                            ],
                          ),
                          sizedBox,
                          TextTitle(
                              title: prodList['proddesc'],
                              ls: 0,
                              fontwght: FontWeight.normal,
                              fontsz: 15),
                          sizedBox,
                          FittedBox(
                            child: ColoredBox(
                              color: Colors.red.shade100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.home,
                                          color: xBlue,
                                        ),
                                        TextTitle(
                                            title:
                                                "7 days service\ncenter replace",
                                            ls: 0,
                                            fontwght: FontWeight.normal,
                                            fontsz: 15)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 80,
                                      child: VerticalDivider(
                                        color: xGrey,
                                        thickness: 2,
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.delivery_dining,
                                          color: xBlue,
                                        ),
                                        TextTitle(
                                            title:
                                                "      Cash on\ndelivery available",
                                            ls: 0,
                                            fontwght: FontWeight.normal,
                                            fontsz: 15)
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 80,
                                      child: VerticalDivider(
                                        color: xGrey,
                                        thickness: 2,
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.assured_workload,
                                          color: xBlue,
                                        ),
                                        TextTitle(
                                            title: "        Plus\n(S-Assured)",
                                            ls: 0,
                                            fontwght: FontWeight.normal,
                                            fontsz: 15)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          sizedBox20,
                          const ProductDetailHeader(title: "Recommended"),
                          SizedBox(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: usersStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot.data!.docs.isEmpty) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "images/inapp/empty.png",
                                          height: 250,
                                          width: 250,
                                        ),
                                        const TextTitle(
                                          title: "Ohh Category is Empty!!",
                                          ls: 0,
                                          fontwght: FontWeight.normal,
                                          fontsz: 15,
                                        )
                                      ],
                                    ),
                                  );
                                }

                                return SingleChildScrollView(
                                  child: StaggeredGridView.countBuilder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 2,
                                    padding: const EdgeInsets.all(10),
                                    itemBuilder: (context, index) {
                                      return ProductCardModel(
                                        products: snapshot.data!.docs[index],
                                      );
                                    },
                                    staggeredTileBuilder: (context) {
                                      return const StaggeredTile.fit(1);
                                    },
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    sizedBox30
                  ]),
            ),
          ),
          bottomSheet: Container(
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
                                back: AppBarbackButton(),
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
                  MaterialButton(
                    color: Colors.black.withOpacity(0.2),
                    minWidth: MediaQuery.of(context).size.width * 0.3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    onPressed: () {
                      context.read<CartProvider>().getItems.firstWhereOrNull(
                                  (prod) =>
                                      prod.documentId ==
                                      prodList['productId']) !=
                              null
                          ? MyMessengerHelper.showSnackBar(
                              scaffoldKey, "This Item already in Cart")
                          : context.read<CartProvider>().addItems(
                                prodList['prodname'],
                                prodList['price'],
                                1,
                                prodList['instock'],
                                prodList['prodimage'],
                                prodList['productId'],
                                prodList['sid'],
                              );
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: xWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
