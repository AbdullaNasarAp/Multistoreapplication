import 'package:flutter/material.dart';
import '../utils/colors.dart';

class CPI extends StatelessWidget {
  const CPI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 100,
      width: MediaQuery.of(context).size.width * 100,
      color: xBlack87,
      child: const Center(
        child: CircularProgressIndicator(
          color: xBlue,
        ),
      ),
    );
  }
}
