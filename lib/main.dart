// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'nav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tarea 6',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          },
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 94, 94, 94),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                'lib/assets/toolbox.png',
                width: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
