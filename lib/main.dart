import 'package:flutter/material.dart';
import 'package:balancemate/home_page.dart';
import 'package:balancemate/setup_page.dart';
import 'package:balancemate/details_page.dart';

void main() {
  runApp(const BalanceMateApp());
}

class BalanceMateApp extends StatelessWidget {
  const BalanceMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DetailsPage(),
    );
  }
}