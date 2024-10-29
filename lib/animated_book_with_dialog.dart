import 'dart:math';

import 'package:flutter/material.dart';
import 'package:host_view/animated_dual_side_container.dart';
import 'package:host_view/constants.dart';
import 'package:host_view/dual_side_container.dart';
import 'package:host_view/expandable_screen.dart';

class AnimatedBookWithDialog extends StatelessWidget {
  final double initialHeight;
  final double initialWidth;
  final double initialRotation;
  final String heroTag;
  final Widget frontWidget;
  final Widget backWidget;

  const AnimatedBookWithDialog({
    super.key,
    this.initialHeight = 50,
    this.initialWidth = 50,
    this.initialRotation = pi / 5,
    this.heroTag = 'book-hero',
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      flightShuttleBuilder: _buildFlightShuttle,
      child: GestureDetector(
        onTap: () => _showExpandableDialog(context),
        child: DualSidedContainer(
          height: initialHeight,
          width: initialWidth,
          rotation: 2 / pi,
          frontWidget: frontWidget,
          backWidget: backWidget,
        ),
      ),
    );
  }

  Widget _buildFlightShuttle(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final bool isPush = flightDirection == HeroFlightDirection.push;

    if (isPush) {
      final tweenAnimation = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: -(3 * pi / 4), end: 0));
      final sizeTween = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: initialHeight, end: initialHeight * 2));

      return Material(
        color: Colors.transparent,
        child: AnimatedFlipBook(
          animation: tweenAnimation,
          sizeAnimation: sizeTween,
          frontWidget: frontWidget,
          backWidget: backWidget,
        ),
      );
    } else {
      final reverseTweenAnimation = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: 2 / pi, end: pi));
      final reverseSizeTween = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: initialHeight * 2, end: initialHeight));
      return Material(
        color: Colors.transparent,
        child: AnimatedDualSidedContainer(
          animation: reverseTweenAnimation,
          sizeAnimation: reverseSizeTween,
          frontWidget: frontWidget,
          backWidget: backWidget,
        ),
      );
    }
  }

  void _showExpandableDialog(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: AnimationConstants.heroTransitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) {
          final slideAnimation = Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ));

          final fadeAnimation = Tween<double>(
            begin: 0.0,
            end: 0.5,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ));

          return Stack(
            children: [
              FadeTransition(
                opacity: fadeAnimation,
                child: Container(
                  color: Colors.black,
                ),
              ),
              SlideTransition(
                position: slideAnimation,
                child: ExpandableScreen(
                  heroTag: heroTag,
                  frontWidget: frontWidget,
                  backWidget: backWidget,
                ),
              ),
            ],
          );
        },
        reverseTransitionDuration: AnimationConstants.heroTransitionDuration,
      ),
    );
  }
}
