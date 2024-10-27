import 'dart:math';

import 'package:flutter/material.dart';
import 'package:host_view/animated_book_with_dialog.dart';

class PropertyListingCard extends StatelessWidget {
  final String propertyImage;
  final String location;
  final String rating;
  final String hostName;
  final String description;
  final bool isSuperhost;
  final VoidCallback? onFavoritePressed;
  final Widget frontWidget;
  final Widget backWidget;

  const PropertyListingCard({
    super.key,
    required this.propertyImage,
    required this.location,
    required this.rating,
    required this.hostName,
    required this.description,
    this.isSuperhost = false,
    this.onFavoritePressed,
    required this.frontWidget,
    required this.backWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          height: MediaQuery.sizeOf(context).height * 0.4,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              image: DecorationImage(
                  image: AssetImage(propertyImage), fit: BoxFit.cover)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSuperhost)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Superhost",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  GestureDetector(
                    onTap: onFavoritePressed,
                    child: const ImageIcon(
                      AssetImage("icons/wish.png"),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
              AnimatedBookWithDialog(
                frontWidget: frontWidget,
                backWidget: backWidget,
                initialRotation: 2 / pi,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Room in $location",
              style: const TextStyle(
                color: Color(0xFF222222),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ImageIcon(
                  AssetImage('icons/star.png'),
                  size: 16,
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  rating,
                  style: const TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
        Text(
          "Stay with $hostName-Creating memories!",
          style: const TextStyle(
            color: Color(0xFF5E5E5E),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        Text(
          description,
          style: const TextStyle(
            color: Color(0xFF5E5E5E),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
