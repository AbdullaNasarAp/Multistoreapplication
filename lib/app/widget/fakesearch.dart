import 'package:flutter/material.dart';
import 'package:siopa/app/screen/minor_screen.dart/search.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';

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
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        Center(
          child: Row(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Icon(
                  Icons.search,
                  color: xWhite,
                ),
              ),
              TextTitle(
                  title: "Search",
                  ls: 0,
                  fontwght: FontWeight.normal,
                  fontsz: 15)
            ],
          ),
        )
      ]),
    );
  }
}
