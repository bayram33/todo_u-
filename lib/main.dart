import 'package:flutter/material.dart';
import 'package:local_storage/pages/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To Do',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange.shade400,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
