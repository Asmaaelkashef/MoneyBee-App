import 'package:MoneyBee/Pages/Home_Content.dart';
import 'package:MoneyBee/Pages/Settings_Page.dart';
import 'package:MoneyBee/Pages/Transactions_Page.dart';
import 'package:MoneyBee/Pages/WishList_Page.dart';
import 'package:MoneyBee/constants.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen_Content(),
    TransactionsPage(),
    WishlistPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 55,
        color: PrimaryColor, 
        backgroundColor: Color.fromARGB(255, 247, 235, 252), 
        buttonBackgroundColor: PrimaryColor,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.home, color: Colors.white, size: 28),
          Icon(Icons.receipt_long, color: Colors.white, size: 28),
          Icon(Icons.favorite, color: Colors.white, size: 28),
          Icon(Icons.settings, color: Colors.white, size: 28),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
