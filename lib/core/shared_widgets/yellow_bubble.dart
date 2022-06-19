import 'package:flutter/material.dart';

class YellowBubble extends StatelessWidget {
  const YellowBubble({
    Key? key,
    required this.context,
    required this.width,
    required this.heigth,
    this.topPosition = 0,
    this.leftPosition = 0,
  }) : super(key: key);

  final BuildContext context;
  final double topPosition;
  final double leftPosition; 
  final double width;
  final double heigth;

  @override
  Widget build(context) {
    return Positioned(
      top: topPosition,
      left: leftPosition,
      child: Container(
        width: width,
        height: heigth,
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(228, 243, 83, 1)),
      ),
    );
  }
}