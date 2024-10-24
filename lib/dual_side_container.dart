// widgets/dual_sided_container.dart
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
