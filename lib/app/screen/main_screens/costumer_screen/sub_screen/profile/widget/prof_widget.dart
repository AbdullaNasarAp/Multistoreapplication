import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';

class InfoCard extends StatelessWidget {
  InfoCard({
    Key? key,
    required this.title1,
    required this.title2,
    required this.title3,
    this.sub1,
    this.sub2,
    this.sub3,
    required this.icondata1,
    required this.icondata2,
    required this.icondata3,
    required this.ontap1,
    required this.ontap2,
    required this.ontap3,
  }) : super(key: key);
  final String title1;
  final String title2;
  final String title3;
  String? sub1;
  String? sub2;
  String? sub3;
  final IconData icondata1;
  final IconData icondata2;
  final IconData icondata3;
  final VoidCallback ontap1;
  final VoidCallback ontap2;
  final VoidCallback ontap3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 260,
        decoration: BoxDecoration(
            color: xWhite,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: xBlue, width: 2)),
        child: Column(
          children: [
            ProfileTile(
                title1: title1,
                sub1: sub1,
                icondata1: icondata1,
                function: ontap1),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: xBlue,
              ),
            ),
            ProfileTile(
                title1: title2,
                sub1: sub2,
                icondata1: icondata2,
                function: ontap2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Divider(
                color: Colors.blue.shade400,
              ),
            ),
            ProfileTile(
              title1: title3,
              sub1: sub3,
              icondata1: icondata3,
              function: ontap3,
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    Key? key,
    required this.title1,
    required this.sub1,
    required this.icondata1,
    required this.function,
  }) : super(key: key);

  final String title1;
  final String? sub1;
  final IconData icondata1;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: function,
      title: Text(
        title1,
        style: const TextStyle(color: xBlack87),
      ),
      subtitle: Text(
        sub1 ?? '',
        style: const TextStyle(color: xBlack87),
      ),
      leading: Icon(
        icondata1,
        color: xBlack87,
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          width: 10,
        ),
        const SizedBox(
          height: 40,
          width: 50,
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
