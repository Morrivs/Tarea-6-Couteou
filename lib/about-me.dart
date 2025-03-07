// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, file_names
import 'package:flutter/material.dart';

class AboutMeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Container(
              width: 500,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 94, 94, 94),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage('lib/assets/justme.png'),
                    radius: 70,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jesimiel Marte Frías',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 217, 217, 217)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'jesimielmarte@gmail.com',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 217, 217, 217)),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '+1 829-763-5218',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 217, 217, 217)),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
