// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final TextEditingController _controller = TextEditingController();
  Color _containerColor = Color.fromARGB(255, 94, 94, 94);
  String _imageAsset = '';

  Future<void> _predictGender() async {
    final name = _controller.text;
    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final gender = data['gender'];

      setState(() {
        if (gender == 'female') {
          _containerColor = Color.fromARGB(255, 244, 147, 184);
          _imageAsset = 'lib/assets/female.png';
        } else if (gender == 'male') {
          _containerColor = Color.fromARGB(255, 105, 171, 225);
          _imageAsset = 'lib/assets/male.png';
        } else {
          _containerColor = Color.fromARGB(
              255, 94, 94, 94); // default color if gender is not found
          _imageAsset = '';
        }
      });
    } else {
      print('Error al obtener datos de la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 50,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Ingresar nombre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 250,
              height: 50,
              child: ElevatedButton(
                onPressed: _predictGender,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 87, 87),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Predecir Género',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: _containerColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 170,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: _imageAsset.isNotEmpty
                      ? ClipOval(
                          child: Image.asset(
                            _imageAsset,
                            width: 100,
                          ),
                        )
                      : Container(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
