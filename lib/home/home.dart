import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF14265A),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 90,
          padding: const EdgeInsets.all(10),
          width: MediaQuery.sizeOf(context).width * .9,
          margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF14265A),
            border: Border.all(color: Colors.white30, width: 3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: const Color(0xFF14265A),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
