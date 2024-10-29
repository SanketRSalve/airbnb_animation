// screens/expandable_screen.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:host_view/dual_side_container.dart';
import 'package:host_view/expandable_bottomsheet.dart';

class ExpandableScreen extends StatelessWidget {
  final String heroTag;
  final Widget frontWidget;
  final Widget backWidget;

  const ExpandableScreen(
      {super.key,
      required this.heroTag,
      required this.frontWidget,
      required this.backWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ExpandableBottomSheet(
        onTapOutside: () => Navigator.of(context).pop(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 100.0, top: 20),
              child: Hero(
                tag: heroTag,
                child: FlipBookContainer(
                  height: 100,
                  width: 100,
                  rotation: 0,
                  xTranslation: 100,
                  frontWidget: frontWidget,
                  backWidget: backWidget,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
