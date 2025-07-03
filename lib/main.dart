import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const QuranApp());
}
class QuranApp extends StatelessWidget {
  const QuranApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Amiri'),
      home: const HomePage(),
    );
  }
}
