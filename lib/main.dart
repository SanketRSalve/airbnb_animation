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
  bool bookOpen = true;
  double dialogBoxHeight = 0.5;
  //Helper to set 45 and 90
  void isOpen() {
    setState(() {
      bookOpen = false;

      if (!bookOpen) {
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
        Tween<double>(begin: pi / 5, end: pi).animate(yAnimationController);

    // Size animation tween
    sizeAnimation = Tween<double>(begin: 50, end: 100).animate(
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
              duration: const Duration(milliseconds: 300),
              bottom: bookOpen ? -MediaQuery.of(context).size.height : 0,
              child: GestureDetector(
                child: Container(
                  height: MediaQuery.of(context).size.height * dialogBoxHeight,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 24,
                        icon: const Icon(
                          Icons.cancel,
                        ),
                        onPressed: () {
                          setState(() {
                            bookOpen = true;
                            if (!bookOpen) {
                              yAnimationController.forward();
                            } else {
                              yAnimationController.reverse();
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
