import 'package:MoneyBee/Pages/Home_Page.dart';
import 'package:flutter/material.dart';

void goHome(BuildContext context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (_) => const Home_Page()),
    (_) => false,
  );
}