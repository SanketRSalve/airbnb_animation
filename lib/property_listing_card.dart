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
          height: MediaQuery.sizeOf(context).height * 0.3,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              color: Colors.red,
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
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Superhost",
                        style: TextStyle(fontSize: 8),
                      ),
                    ),
                  GestureDetector(
                    onTap: onFavoritePressed,
                    child: const Icon(
                      Icons.favorite_outline,
                      color: Colors.white,
                      fill: 1.0,
                      size: 20,
                    ),
                  ),
                ],
              ),
              AnimatedBookWithDialog(
                frontWidget: frontWidget,
                backWidget: backWidget,
                initialRotation: pi / 4.5,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Room in $location",
              style: const TextStyle(fontSize: 8),
            ),
            Text(
              rating,
              style: const TextStyle(fontSize: 8),
            ),
          ],
        ),
        Text(
          "Stay with $hostName-Creating memories!",
          style: const TextStyle(fontSize: 6),
        ),
        Text(
          description,
          style: const TextStyle(fontSize: 6),
        ),
      ],
    );
  }
}
