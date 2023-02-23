import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/product_details/product_detail.dart';
import 'package:siopa/app/widget/button_container.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key, required this.e});
  final QueryDocumentSnapshot e;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailScreen(prodList: e),
        ));
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: Image.network(e['prodimage'].first),
              ),
              const SizedBox(
                width: 15,
              ),
              Flexible(
                child: Column(
                  children: [
                    TextTitle(
                        title: e['prodname'],
                        ls: 0,
                        mL: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwght: FontWeight.normal,
                        fontsz: 16)
                  ],
                ),
              )
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
