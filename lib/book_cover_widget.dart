import 'package:flutter/material.dart';
import 'package:host_view/profile_image.dart';

class SimpleBookCover extends StatelessWidget {
  final double width;
  final double height;

  const SimpleBookCover({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        color: Color(0xFFF5F5F5), //Off-white base color
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2),
            bottomLeft: Radius.circular(2),
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Align(
                alignment: Alignment.center,
                child: PhotoFrame(
                  width: width / 2,
                  height: height / 2,
                )),
          ),
          // Top gradient strip
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 10,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white.withOpacity(0),
                  ],
                  stops: const [0.0, 1.0],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
          // Left gradient strip
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            width: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFFBEB5B3),
                    Colors.white.withOpacity(0),
                  ],
                  stops: const [0.0, 1.0],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
          ),

          Positioned(
            top: 0,
            left: 2,
            bottom: 0,
            width: 5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    const Color(0xFFBEB5B3),
                    Colors.white.withOpacity(0),
                  ],
                  stops: const [0.0, 1.0],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  bottomLeft: Radius.circular(2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Create a circular path
    Path path = Path();
    path.addOval(Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: size.width / 2));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class PhotoFrame extends StatelessWidget {
  const PhotoFrame({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border:
              Border.all(color: Colors.black, width: 0.5), // Border settings
        ),
        child: ClipPath(
          clipper: CircleClipper(),
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/profile_1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
