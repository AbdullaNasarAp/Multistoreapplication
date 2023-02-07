import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/main_screens/widget/product_card_model.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class MenGallery extends StatelessWidget {
  const MenGallery({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('maincateg', isEqualTo: 'Men')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
            physics: const NeverScrollableScrollPhysics(),
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
    );
  }
}
