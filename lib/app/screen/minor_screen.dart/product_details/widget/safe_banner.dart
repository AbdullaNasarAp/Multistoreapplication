import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';

class SafeBanner extends StatelessWidget {
  const SafeBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ColoredBox(
        color: Colors.red.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Column(
                children: const [
                  Icon(
                    Icons.home,
                    color: xBlue,
                  ),
                  TextTitle(
                      title: "7 days service\ncenter replace",
                      ls: 0,
                      fontwght: FontWeight.normal,
                      fontsz: 15)
                ],
              ),
              const SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: xGrey,
                  thickness: 2,
                ),
              ),
              Column(
                children: const [
                  Icon(
                    Icons.delivery_dining,
                    color: xBlue,
                  ),
                  TextTitle(
                      title: "      Cash on\ndelivery available",
                      ls: 0,
                      fontwght: FontWeight.normal,
                      fontsz: 15)
                ],
              ),
              const SizedBox(
                height: 80,
                child: VerticalDivider(
                  color: xGrey,
                  thickness: 2,
                ),
              ),
              Column(
                children: const [
                  Icon(
                    Icons.assured_workload,
                    color: xBlue,
                  ),
                  TextTitle(
                      title: "        Plus\n(S-Assured)",
                      ls: 0,
                      fontwght: FontWeight.normal,
                      fontsz: 15)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Icon(
          Icons.star,
          color: Colors.orangeAccent,
        ),
        Icon(
          Icons.star_border,
          color: Colors.orangeAccent,
        ),
      ],
    );
  }
}

class HotDealBanner extends StatelessWidget {
  const HotDealBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 30,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.elliptical(50, 50)),
        color: xGreen,
      ),
      child: const Center(
        child: TextTitle(
            title: "Hot Deal", ls: 0, fontwght: FontWeight.normal, fontsz: 15),
      ),
    );
  }
}
