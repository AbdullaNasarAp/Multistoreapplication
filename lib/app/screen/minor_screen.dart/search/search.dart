import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siopa/app/controller/costumer_control/search.dart';
import 'package:siopa/app/screen/minor_screen.dart/search/widget.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/app_bar.dart';
import 'package:siopa/app/widget/button_container.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, search, child) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: xBlue,
              leading: const AppBarbackButton(),
              title: CupertinoSearchTextField(
                autocorrect: true,
                autofocus: true,
                backgroundColor: xWhite,
                onChanged: (value) {
                  search.searchNotifier(value);
                },
              ),
            ),
            body: search.searchInput == ''
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://cdni.iconscout.com/illustration/premium/thumb/searching-in-box-3428236-2902705.png",
                          height: 300,
                          width: 300,
                        ),
                        const TextTitle(
                          title: "Ohh Pls any thing!!",
                          ls: 0,
                          fontwght: FontWeight.normal,
                          fontsz: 15,
                        ),
                        const ButtonContainer(
                            kWidth: 300,
                            kHeight: 50,
                            kColors: xBlue,
                            title: "Pls search anything",
                            ls: 0,
                            fontwght: FontWeight.normal,
                            fontsz: 17,
                            icons: Icons.search,
                            bRadius: 20)
                      ],
                    ),
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Material(
                            child: Center(child: CircularProgressIndicator()));
                      }

                      final result = snapshot.data!.docs.where((e) =>
                          e['prodname'.toLowerCase()]
                              .contains(search.searchInput.toLowerCase()));

                      return ListView(
                        children: result.map((e) {
                          return SearchItem(
                            e: e,
                          );
                        }).toList(),
                      );
                    }));
      },
    );
  }
}
