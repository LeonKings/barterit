import 'package:flutter/material.dart';

import '../../model/user.dart';
import 'barterscreen.dart';
import 'chatscreen.dart';
import 'profiletabscreen.dart';
import 'additemscreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({super.key, required this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String maintitle = "Buyer";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      BarterScreen(user: widget.user),
      AddItemScreen(user: widget.user),
      ChatScreen(user: widget.user),
      ProfileTabScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.swap_horizontal_circle_outlined,
              ),
              label: "Barter"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart,
              ),
              label: "Add Item"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message_outlined,
              ),
              label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int value) {
    setState(() {
      _currentIndex = value;
      if (_currentIndex == 0) {
        maintitle = "Buyer";
      }
      if (_currentIndex == 1) {
        maintitle = "Seller";
      }
      if (_currentIndex == 3) {
        maintitle = "Profile";
      }
      if (_currentIndex == 2) {
        maintitle = "News";
      }
    });
  }
}
