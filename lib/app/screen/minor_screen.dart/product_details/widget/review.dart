import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/colors.dart';
import '../../../../widget/button_container.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    this.reviewStream,
  });
  final dynamic reviewStream;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
        header: const TextTitle(
            title: "Reviews",
            color: xred,
            ls: 0,
            fontwght: FontWeight.bold,
            fontsz: 20),
        collapsed: SizedBox(
          height: 80,
          child: ReviewExpanded(
            reviewStream: reviewStream,
          ),
        ),
        expanded: ReviewExpanded(
          reviewStream: reviewStream,
        ));
  }
}

class ReviewExpanded extends StatelessWidget {
  const ReviewExpanded({super.key, this.reviewStream});
  final dynamic reviewStream;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: reviewStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: TextTitle(
                title: "Ohh reviews is Empty!!",
                ls: 0,
                fontwght: FontWeight.normal,
                fontsz: 15,
              ),
            ),
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: TextTitle(
                    title: "${snapshot.data!.docs[index]['name'][0]}"
                        .toUpperCase(),
                    ls: 0,
                    fontwght: FontWeight.bold,
                    fontsz: 14),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextTitle(
                      title: snapshot.data!.docs[index]['name'],
                      ls: 0,
                      fontwght: FontWeight.bold,
                      fontsz: 13),
                  Row(
                    children: [
                      const FaIcon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 18,
                      ),
                      TextTitle(
                          title: snapshot.data!.docs[index]['rate'].toString(),
                          ls: 0,
                          fontwght: FontWeight.normal,
                          fontsz: 13),
                    ],
                  ),
                ],
              ),
              subtitle: TextTitle(
                  title: snapshot.data!.docs[index]['comment'],
                  ls: 0,
                  color: xGrey,
                  fontwght: FontWeight.normal,
                  fontsz: 16),
            );
          },
        );
      },
    );
  }
}
