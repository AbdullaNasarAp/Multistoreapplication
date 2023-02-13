import 'package:flutter/material.dart';
import 'package:siopa/app/utils/colors.dart';
import 'package:siopa/app/widget/button_container.dart';

class StaticsWidget extends StatelessWidget {
  const StaticsWidget({
    super.key,
    required this.value0,
    required this.value1,
    required this.decimal,
  });
  final String value0;
  final dynamic value1;
  final int decimal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: xWhite,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: xBlue.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            Positioned(
                top: -20,
                left: -50,
                child: Container(
                    height: 230,
                    width: 250,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: xBlue.withOpacity(0.1)))),
            Positioned(
                left: -80,
                top: -50,
                child: Container(
                    height: 150,
                    width: 180,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: xBlue.withOpacity(0.5)))),
            Positioned(
              child: Column(
                children: [
                  Container(
                    height: 180,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextTitle(
                          title: value0,
                          ls: 0,
                          fontsz: 16,
                          fontwght: FontWeight.bold,
                        ),
                        AnimatedCount(
                          decimal: decimal,
                          count: value1,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimatedCount extends StatefulWidget {
  const AnimatedCount({
    super.key,
    required this.decimal,
    required this.count,
  });
  final int decimal;
  final dynamic count;

  @override
  State<AnimatedCount> createState() => _AnimatedCountState();
}

class _AnimatedCountState extends State<AnimatedCount>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _animationController;
    setState(() {
      _animation = Tween(begin: _animation.value, end: widget.count)
          .animate(_animationController);
    });
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.decimal == 2
              ? "₹ ${_animation.value.toStringAsFixed(widget.decimal)}"
              : "${_animation.value.toStringAsFixed(widget.decimal)}",
          style: const TextStyle(
            color: xBlack87,
            letterSpacing: 0,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        );
      },
    );
  }
}
