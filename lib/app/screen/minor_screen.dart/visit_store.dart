import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/supplier_control/visitor_store.dart';
import 'package:siopa/app/screen/main_screens/widget/product_card_model.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class VisitStore extends StatelessWidget {
  const VisitStore({super.key, required this.supId});
  final String supId;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
        .collection('products')
        .where('sid', isEqualTo: supId)
        .snapshots();
    CollectionReference users =
        FirebaseFirestore.instance.collection('suppliers');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(supId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              flexibleSpace: Image.asset(
                "images/inapp/coverimage.jpg",
                fit: BoxFit.fitWidth,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration:
                        BoxDecoration(border: Border.all(color: xGreen)),
                    child: Image.network(
                      data['storelogo'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Consumer<VisitorStore>(
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          TextTitle(
                              title: "${data['storename']}".toUpperCase(),
                              ls: 0,
                              fontwght: FontWeight.bold,
                              fontsz: 16),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                color: xBlue,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: MaterialButton(
                                  onPressed: () {
                                    value.followunfollowStore();
                                  },
                                  child: value.follow == false
                                      ? const TextTitle(
                                          title: "FOLLOW",
                                          ls: 0,
                                          color: xWhite,
                                          fontwght: FontWeight.w400,
                                          fontsz: 16)
                                      : const TextTitle(
                                          title: "UNFOLLOW",
                                          ls: 0,
                                          color: xWhite,
                                          fontwght: FontWeight.w400,
                                          fontsz: 16)))
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
