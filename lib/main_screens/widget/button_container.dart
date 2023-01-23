import 'package:flutter/material.dart';
import 'package:siopa/utils/colors.dart';

class ContainerButtonImage extends StatelessWidget {
  const ContainerButtonImage({
    Key? key,
    required this.image,
    required this.onPress,
    required this.title,
  }) : super(key: key);
  final String image;
  final Function() onPress;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPress;
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: xBlack,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                image,
                filterQuality: FilterQuality.high,
                cacheHeight: 40,
                cacheWidth: 40,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(color: xGrey),
            ),
          )
        ],
      ),
    );
  }
}

class LoginContainer extends StatelessWidget {
  const LoginContainer({
    Key? key,
    required this.str,
  }) : super(key: key);
  final String str;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Center(
          child: Text(
        str,
        style: const TextStyle(
          color: xBlack,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      )),
    );
  }
}
