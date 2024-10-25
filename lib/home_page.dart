import 'package:flutter/material.dart';
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
              ImageIcon(AssetImage("icons/magnifying-glass.png")),
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
        actions: [
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: const Color(0xFF767676))),
              child: const ImageIcon(
                AssetImage('icons/filter.png'),
                size: 16,
              )),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/loupe.png')), label: "Explore"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/love.png')),
              label: "Wishlists"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/airbnb.png')), label: "Trips"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/chat.png')), label: "Messages"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('icons/user.png')), label: "Profile")
        ],
        unselectedItemColor: const Color(0xFF767676),
        selectedItemColor: const Color(0xFFFF5A5F),
      ),
    );
  }

  Widget _buildContainer({required String text, required Color color}) {
    return Container(
      height: 50,
      width: 50,
      color: color,
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }
}
