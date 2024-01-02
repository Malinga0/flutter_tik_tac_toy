import 'package:flutter/material.dart';
import 'package:flutter_tik_tac_toy/home_screen.dart';

void main() {
  runApp(const TicTak());
}

class TicTak extends StatelessWidget {
  const TicTak({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
