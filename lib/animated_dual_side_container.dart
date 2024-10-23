// widgets/animated_dual_sided_container.dart
import 'package:flutter/material.dart';
import 'package:host_view/dual_side_container.dart';

class AnimatedDualSidedContainer extends StatelessWidget {
  final Animation<double> animation;
  final Animation<double> sizeAnimation;
  final Widget frontWidget;
  final Widget backWidget;

  const AnimatedDualSidedContainer({
    super.key,
    required this.animation,
    required this.sizeAnimation,
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return DualSidedContainer(
          height: sizeAnimation.value,
          width: sizeAnimation.value,
          rotation: animation.value,
          frontWidget: frontWidget,
          backWidget: backWidget,
        );
      },
    );
  }
}
