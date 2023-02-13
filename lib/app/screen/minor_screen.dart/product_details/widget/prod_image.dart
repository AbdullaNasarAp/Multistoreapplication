import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/prod_detail.dart';
import 'package:siopa/app/controller/costumer_control/wishlist.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/widget/full_screen_preview.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:collection/collection.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageList,
    required this.prodList,
  });

  final List imageList;
  final dynamic prodList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: xBlue.withOpacity(0.1)),
          height: MediaQuery.of(context).size.height * 0.45,
          child: Swiper(
              pagination:
                  const SwiperPagination(builder: SwiperPagination.dots),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          FullScreenViewOfProduct(imageList: imageList),
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
                  child: Consumer<ProductDetailProvider>(
                    builder: (context, pdpf, child) {
                      return IconButton(
                          onPressed: () {
                            pdpf.productToFavorite(context, prodList);
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
                                ));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
