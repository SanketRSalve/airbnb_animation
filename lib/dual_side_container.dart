// widgets/dual_sided_container.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:host_view/constants.dart';

class DualSidedContainer extends StatelessWidget {
  final double height;
  final double width;
  final double rotation;
  final Widget frontWidget;
  final Widget backWidget;

  const DualSidedContainer({
    super.key,
    required this.height,
    required this.width,
    required this.rotation,
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, AnimationConstants.perspective),
          child: SizedBox(
            height: height,
            width: width,
            child: frontWidget,
          ),
        ),
        Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, AnimationConstants.frontPerspective)
            ..rotateY(rotation),
          child: SizedBox(
            height: height,
            width: width,
            child: backWidget,
          ),
        ),
      ],
    );
  }
}

class FlipBookContainer extends StatelessWidget {
  final double height;
  final double width;
  final double rotation;
  final Widget frontWidget;
  final Widget backWidget;
  final dynamic xTranslation;

  const FlipBookContainer({
    super.key,
    required this.height,
    required this.width,
    required this.rotation,
    required this.frontWidget,
    required this.backWidget,
    this.xTranslation,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, AnimationConstants.perspective)
            ..translate(xTranslation ?? 0),
          child: const ExpandedLeftSide(),
        ),
        Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
            ..setEntry(3, 2, AnimationConstants.frontPerspective)
            ..rotateY(rotation),
          child: const ExpandededRightSide(),
        ),
      ],
    );
  }
}

class ExpandededRightSide extends StatelessWidget {
  const ExpandededRightSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('images/profile_1.jpg'),
                    fit: BoxFit.cover)),
          ),
          const Text(
            "Nikki",
            style: TextStyle(fontSize: 4),
          ),
          const Text(
            "Superhost",
            style: TextStyle(fontSize: 4),
          )
        ],
      ),
    );
  }
}

class ExpandedLeftSide extends StatelessWidget {
  const ExpandedLeftSide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "20",
            style: TextStyle(fontSize: 4),
          ),
          Text(
            "Reviews",
            style: TextStyle(fontSize: 4),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          ),
          Text(
            "4.75",
            style: TextStyle(fontSize: 4),
          ),
          Text(
            "Rating",
            style: TextStyle(fontSize: 4),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            indent: 10,
            endIndent: 10,
          ),
          Text(
            "12",
            style: TextStyle(fontSize: 4),
          ),
          Text(
            "Years hosting",
            style: TextStyle(fontSize: 4),
          )
        ],
      ),
    );
  }
}
