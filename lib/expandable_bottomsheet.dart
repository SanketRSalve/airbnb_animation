// widgets/expandable_bottom_sheet.dart
import 'package:flutter/material.dart';

class ExpandableBottomSheet extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTapOutside;
  final VoidCallback? onToggleExpand;

  const ExpandableBottomSheet({
    super.key,
    required this.child,
    this.onTapOutside,
    this.onToggleExpand,
  });

  @override
  State<ExpandableBottomSheet> createState() => _ExpandableBottomSheetState();
}

class _ExpandableBottomSheetState extends State<ExpandableBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _heightAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  void _toggleExpand() {
    if (isExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      isExpanded = !isExpanded;
    });
    widget.onToggleExpand?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onTapOutside,
          child: Container(color: Colors.transparent),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedBuilder(
            animation: _heightAnimation,
            builder: (context, child) => FractionallySizedBox(
              heightFactor: _heightAnimation.value,
              child: GestureDetector(
                onTap: _toggleExpand,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
