import 'package:flutter/material.dart';
import 'package:host_view/animated_book_with_dialog.dart';
import 'package:host_view/property_listing_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 30,
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(50.0)),
          child: const Row(
            children: [
              Icon(
                Icons.search,
                size: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "San Francisco",
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    "New 1, 2014 = Feb 1, 2023, 2 guests",
                    style: TextStyle(fontSize: 6),
                  )
                ],
              ),
            ],
          ),
        ),
        actions: const [
          Icon(Icons.tune),
        ],
      ),
      body: PropertyListingCard(
        propertyImage: "images/1.jpg",
        location: "San Francisco",
        rating: "4.75(20)",
        hostName: "Nikki",
        description: "New! Quiet, private studio. Private bath + Garden",
        isSuperhost: true,
        frontWidget: _buildContainer(text: "Front", color: Colors.purple),
        backWidget: _buildContainer(text: "Back", color: Colors.grey),
        onFavoritePressed: () {
          // Handle favorite button press
        },
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      ]),
    );
  }

  Widget _buildContainer({required String text, required Color color}) {
    return Container(
      height: 50,
      width: 50,
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
