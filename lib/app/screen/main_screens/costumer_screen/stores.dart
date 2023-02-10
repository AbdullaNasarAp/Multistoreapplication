import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/visit_store.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: xWhite,
        appBar: AppBar(
          title: const AppBarTitle(title: "Stores"),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("suppliers").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VisitStore(
                          supId: snapshot.data?.docs[index]['sid'] ?? 0,
                        ),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      height: 10,
                      width: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              snapshot.data!.docs[index]['storelogo'],
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          ),
                          TextTitle(
                              title:
                                  "${snapshot.data!.docs[index]['storename']}"
                                      .toUpperCase(),
                              ls: 0,
                              fontwght: FontWeight.bold,
                              fontsz: 15)
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
