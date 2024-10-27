import 'package:flutter/material.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({super.key, required this.radius});
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      decoration: const BoxDecoration(
          color: Colors.pink,
          image: DecorationImage(
              image: AssetImage('images/profile_1.jpg'), fit: BoxFit.cover)),
    );
  }
}
