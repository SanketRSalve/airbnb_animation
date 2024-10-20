import 'package:flutter/material.dart';
import 'dart:math' show pi;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController yAnimationController;
  late Animation<double> tweenAnimation;
  late Animation<double> sizeAnimation;
  bool bookOpen = false;
  //Helper to set 45 and 90
  void isOpen() {
    setState(() {
      bookOpen = !bookOpen;

      if (bookOpen) {
        yAnimationController.forward();
      } else {
        yAnimationController.reverse();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    yAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    tweenAnimation =
        Tween<double>(begin: pi, end: pi / 5).animate(yAnimationController);

    // Size animation tween
    sizeAnimation = Tween<double>(begin: 100, end: 50).animate(
        CurvedAnimation(parent: yAnimationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    yAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          isOpen();
        },
        child: Stack(
          children: [
            AnimatedPositioned(
              top: bookOpen ? 0 : MediaQuery.of(context).size.height / 2,
              left: bookOpen ? 0 : MediaQuery.of(context).size.width / 2,
              duration: const Duration(milliseconds: 300),
              child: AnimatedBuilder(
                  animation: yAnimationController,
                  builder: (context, child) {
                    return Stack(
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..setEntry(3, 2, 0.001),
                          child: Container(
                              height: sizeAnimation.value,
                              width: sizeAnimation.value,
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
                            height: sizeAnimation.value,
                            width: sizeAnimation.value,
                            decoration: const BoxDecoration(
                              color: Colors.pink,
                            ),
                            child: const Text("PINK"),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}