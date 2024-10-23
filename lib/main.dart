// constants.dart
import 'dart:math';
import 'package:flutter/material.dart';

class AnimationConstants {
  static const Duration heroTransitionDuration = Duration(milliseconds: 600);
  static const Duration expandTransitionDuration = Duration(milliseconds: 600);
  static const double perspective = 0.001;
  static const double frontPerspective = 0.0015;
}

// widgets/dual_sided_container.dart
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
          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
          child: SizedBox(
            height: height,
            width: width,
            child: frontWidget,
          ),
        ),
        Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
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

// widgets/animated_dual_sided_container.dart
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

// widgets/expandable_bottom_sheet.dart
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
        curve: Curves.easeInOut,
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

// screens/home_screen.dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation Example')),
      body: Hero(
        tag: 'hero-icon',
        flightShuttleBuilder: _buildFlightShuttle,
        child: GestureDetector(
          onTap: () => _navigateToExpandableScreen(context),
          child: DualSidedContainer(
            height: 50,
            width: 50,
            rotation: pi / 5,
            frontWidget: _buildColoredContainer(Colors.blue, "BLUE"),
            backWidget: _buildColoredContainer(Colors.pink, "PINK"),
          ),
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
          .drive(Tween<double>(begin: pi / 5, end: pi));
      final sizeTween = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: 50, end: 100));

      return Material(
        color: Colors.transparent,
        child: AnimatedDualSidedContainer(
          animation: tweenAnimation,
          sizeAnimation: sizeTween,
          frontWidget: _buildColoredContainer(Colors.blue, "BLUE"),
          backWidget: _buildColoredContainer(Colors.pink, "PINK"),
        ),
      );
    } else {
      final reverseTweenAnimation = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: pi / 5, end: 0));
      final reverseSizeTween = animation
          .drive(CurveTween(curve: Curves.linear))
          .drive(Tween<double>(begin: 100, end: 50));

      return Material(
        color: Colors.transparent,
        child: AnimatedDualSidedContainer(
          animation: reverseTweenAnimation,
          sizeAnimation: reverseSizeTween,
          frontWidget: _buildColoredContainer(Colors.blue, "BLUE"),
          backWidget: _buildColoredContainer(Colors.pink, "PINK"),
        ),
      );
    }
  }

  Widget _buildColoredContainer(Color color, String text) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Text(text),
    );
  }

  void _navigateToExpandableScreen(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        transitionDuration: AnimationConstants.heroTransitionDuration,
        pageBuilder: (context, animation, secondaryAnimation) {
          // create a combined animation for both the overlay and the bottomsheet
          final slideAnimation = Tween(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          // Animate the overlay opacity
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
                child: const ExpandableScreen(),
              )
            ],
          );
        },
      ),
    );
  }
}

// screens/expandable_screen.dart
class ExpandableScreen extends StatelessWidget {
  const ExpandableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ExpandableBottomSheet(
        onTapOutside: () => Navigator.of(context).pop(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Hero(
                tag: 'hero-icon',
                child: DualSidedContainer(
                  height: 100,
                  width: 100,
                  rotation: pi,
                  frontWidget: _buildColoredContainer(Colors.blue, "BLUE"),
                  backWidget: _buildColoredContainer(Colors.pink, "PINK"),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoredContainer(Color color, String text) {
    return Container(
      decoration: BoxDecoration(color: color),
      child: Text(text),
    );
  }
}

// main.dart
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
