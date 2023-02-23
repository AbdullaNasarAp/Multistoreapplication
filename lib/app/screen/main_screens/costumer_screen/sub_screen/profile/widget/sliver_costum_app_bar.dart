import 'package:flutter/material.dart';
import '../../../../../../utils/colors.dart';

class SliverCostumAppBar extends StatelessWidget {
  const SliverCostumAppBar({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      elevation: 0,
      backgroundColor: xBlue,
      expandedHeight: 140,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          return FlexibleSpaceBar(
            title: AnimatedOpacity(
              opacity: constraints.biggest.height <= 120 ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                "Accounts".toUpperCase(),
                style: const TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: xWhite),
              ),
            ),
            background: Container(
              decoration: const BoxDecoration(color: xBlue),
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 30),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundImage: AssetImage("images/inapp/guest.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        data['name'] == ''
                            ? 'guest'.toUpperCase()
                            : data['name'].toUpperCase(),
                        style: const TextStyle(
                            fontSize: 24,
                            color: xWhite,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
