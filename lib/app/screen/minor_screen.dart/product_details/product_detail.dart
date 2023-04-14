import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/widget/product_card_model.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/bottum_sheet.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/prod_detail_header.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/prod_image.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/review.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/safe_banner.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, this.prodList});
  final dynamic prodList;
  late List<dynamic> imageList = prodList['prodimage'];

  @override
  Widget build(BuildContext context) {
    var onSale = prodList['discount'];
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: prodList['maincateg'])
        .where('subcateg', isEqualTo: prodList['subcateg'])
        .snapshots();

    final Stream<QuerySnapshot> reviewStream = FirebaseFirestore.instance
        .collection('products')
        .doc(prodList['productId'])
        .collection('reviews')
        .snapshots();

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
                padding: const EdgeInsets.only(bottom: 60),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(imageList: imageList, prodList: prodList),
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
                            prodList['discount'] == 0
                                ? const SizedBox(
                                    height: 0,
                                  )
                                : Column(
                                    children: [
                                      const HotDealBanner(),
                                      TextTitle(
                                          title: "${prodList['discount']}% OFF",
                                          ls: 0,
                                          color: Colors.green,
                                          fontwght: FontWeight.bold,
                                          fontsz: 20),
                                    ],
                                  ),
                            sizedBox,
                            Row(
                              children: [
                                const TextTitle(
                                    title: "MRP",
                                    ls: 0,
                                    color: xBlack87,
                                    fontwght: FontWeight.bold,
                                    fontsz: 20),
                                const SizedBox(
                                  width: 10,
                                ),
                                onSale == 0
                                    ? TextTitle(
                                        title: prodList['price']
                                            .toStringAsFixed(1),
                                        ls: 0,
                                        color: xred,
                                        fontwght: FontWeight.bold,
                                        fontsz: 20)
                                    : TextTitle(
                                        title: prodList['price']
                                            .toStringAsFixed(1),
                                        ls: 0,
                                        color: xGrey,
                                        decor: TextDecoration.lineThrough,
                                        fontwght: FontWeight.bold,
                                        fontsz: 18),
                                const SizedBox(
                                  width: 10,
                                ),
                                onSale == 0
                                    ? const Text("")
                                    : TextTitle(
                                        title: ((1 - (onSale / 100)) *
                                                prodList['price'])
                                            .toStringAsFixed(1),
                                        ls: 0,
                                        color: xred,
                                        fontwght: FontWeight.bold,
                                        fontsz: 20),
                              ],
                            ),
                            sizedBox,
                            prodList['instock'] == 0
                                ? const TextTitle(
                                    title: "This Item is out of stock",
                                    ls: 0,
                                    fontwght: FontWeight.bold,
                                    fontsz: 18,
                                    color: Colors.red,
                                  )
                                : TextTitle(
                                    title:
                                        "${prodList['instock'].toString()} Pieces avalailable on stock",
                                    color: prodList['instock'] > 20
                                        ? Colors.green
                                        : Colors.red,
                                    ls: 0,
                                    fontwght: FontWeight.normal,
                                    fontsz: 16),
                            sizedBox,
                            const RatingStar(),
                            sizedBox,
                            TextTitle(
                                title: prodList['proddesc'],
                                ls: 0,
                                fontwght: FontWeight.normal,
                                fontsz: 15),
                            sizedBox,
                            const SafeBanner(),
                            sizedBox20,
                            Reviews(reviewStream: reviewStream),
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
            bottomSheet: BottumSheet(
              prodList: prodList,
              scaffoldKey: scaffoldKey,
            )),
      ),
    );
  }
}
