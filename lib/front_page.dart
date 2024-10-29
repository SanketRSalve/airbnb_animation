import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key, required this.width, required this.height});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8))),
    );
  }
}
