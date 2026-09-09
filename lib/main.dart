import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const KangleipakGoApp());
}

class KangleipakGoApp extends StatelessWidget {
  const KangleipakGoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KangleipakGo',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF176B3A),
        scaffoldBackgroundColor: const Color(0xFFF8FAF8),
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
