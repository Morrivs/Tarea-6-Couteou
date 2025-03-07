// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class AgeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: 300, // Ancho del TextField
                height: 50, // Alto del TextField
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Ingresar edad',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300, // Ancho del botón
              height: 50, // Alto del botón
              child: ElevatedButton(
                onPressed: () {
                  // Acción del botón
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 87, 87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Predecir Edad',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 40),
            Flexible(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                padding: EdgeInsets.symmetric(horizontal: 60),
                children: [
                  IconContainer(icon: Icons.child_care),
                  IconContainer(icon: Icons.school),
                  IconContainer(icon: Icons.work),
                  IconContainer(icon: Icons.elderly),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 300, // Ancho deseado para el Container
              height: 100, // Alto deseado para el Container
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;

  const IconContainer({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50, // Ancho deseado para el ícono
      height: 50, // Alto deseado para el ícono
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Icon(
          icon,
          color: Colors.black,
          size: 50,
        ),
      ),
    );
  }
}
