import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/search.dart';
import 'package:siopa/app/utils/colors.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        ));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              width: 1.4,
              color: xBlue,
            )),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              Text(
                "What are you looking for?",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
          Container(
            height: 32,
            width: 75,
            decoration: BoxDecoration(
              border: Border.all(color: xBlue, width: 2),
              color: xBlack87,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Center(
              child: Text(
                "Search",
                style: TextStyle(color: xWhite, fontSize: 16),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
