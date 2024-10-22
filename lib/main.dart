import 'package:flutter/material.dart';
import 'dart:math';


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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController yAnimationController;
  late Animation<double> tweenAnimation;

  @override
  void initState() {
    super.initState();
    yAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    yAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero Animation Example')),
      body: Hero(
        flightShuttleBuilder: (flightContext, animation, flightDirection,
            fromHeroContext, toHeroContext) {
          // For push animation:
          final tweenAnimation = animation
              .drive(CurveTween(curve: Curves.linear))
              .drive(Tween<double>(begin: pi / 5, end: pi));
          final sizeTween = animation
              .drive(CurveTween(curve: Curves.linear))
              .drive(Tween<double>(begin: 50, end: 100));
          final reverseSizeTween = animation
              .drive(CurveTween(curve: Curves.linear))
              .drive(Tween<double>(begin: 100, end: 50));
          return switch (flightDirection) {
            HeroFlightDirection.push => Material(
                color: Colors.transparent,
                child: AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      return Stack(children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
                          child: Container(
                              height: sizeTween.value,
                              width: sizeTween.value,
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                              ),
                              child: const Text("BLUE")),
                        ),
                        Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.0015)
                              ..rotateY(tweenAnimation.value),
                            child: Container(
                              height: sizeTween.value,
                              width: sizeTween.value,
                              decoration: const BoxDecoration(
                                color: Colors.pink,
                              ),
                              child: const Text("PINK"),
                            ))
                      ]);
                    }),
              ),
            HeroFlightDirection.pop => Material(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    final reverseTweenAnimation = animation
                        .drive(CurveTween(curve: Curves.linear))
                        .drive(Tween<double>(
                            begin: pi / 5, end: 0)); // Changed this line
                    return Stack(children: [
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..setEntry(3, 2, 0.001),
                        child: Container(
                          height: reverseSizeTween.value,
                          width: reverseSizeTween.value,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: const Text("BLUE"),
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.0015)
                          ..rotateY(reverseTweenAnimation
                              .value), // Removed the negative sign
                        child: Container(
                          height: reverseSizeTween.value,
                          width: reverseSizeTween.value,
                          decoration: const BoxDecoration(
                            color: Colors.pink,
                          ),
                          child: const Text("PINK"),
                        ),
                      )
                    ]);
                  },
                ),
              ),
          };
        },
        tag: 'hero-icon',
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: const ExpandableScreen(),
                ),
              ),
            );
          },
          child: Stack(
            children: [
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()..setEntry(3, 2, 0.001),
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                    ),
                    child: const Text("BLUE")),
              ),
              Transform(
                  alignment: Alignment.centerLeft,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0015)
                    ..rotateY(pi / 5),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                    ),
                    child: const Text("PINK"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandableScreen extends StatefulWidget {
  const ExpandableScreen({super.key});

  @override
  _ExpandableScreenState createState() => _ExpandableScreenState();
}

class _ExpandableScreenState extends State<ExpandableScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _heightAnimation;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller for expanding screen animation
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Define height animation from half to full screen
    _heightAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _animationController!, curve: Curves.easeInOut),
    );

    // Start animation for opening the screen halfway
    _animationController?.value = 0; // Start at half (0.5 of full screen)
  }

  void toggleExpand() {
    if (isExpanded) {
      _animationController?.reverse();
    } else {
      _animationController?.forward();
    }
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pop(), // Close screen on tap outside
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedBuilder(
              animation: _heightAnimation!,
              builder: (context, child) {
                return FractionallySizedBox(
                  heightFactor: _heightAnimation!.value,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: toggleExpand, // Toggle expansion on tap
                          child: Hero(
                            tag: 'hero-icon',
                            child: Stack(
                              children: [
                                Transform(
                                  alignment: Alignment.centerLeft,
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001),
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: Colors.blue,
                                      ),
                                      child: const Text("BLUE")),
                                ),
                                Transform(
                                    alignment: Alignment.centerLeft,
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.0015)
                                      ..rotateY(pi),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: const BoxDecoration(
                                        color: Colors.pink,
                                      ),
                                      child: const Text("PINK"),
                                    ))
                              ],
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
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }
}
