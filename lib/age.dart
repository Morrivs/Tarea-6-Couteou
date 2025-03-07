import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _message = '';
  Color _childColor = Colors.grey;
  Color _teenColor = Colors.grey;
  Color _adultColor = Colors.grey;
  Color _seniorColor = Colors.grey;

  Future<void> _predictAge() async {
    final name = _controller.text;
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final age = data['age'];

      String ageGroup;
      if (age < 13) {
        ageGroup = 'niño';
        _childColor = Color.fromARGB(255, 180, 221, 255);
        _teenColor = Colors.grey;
        _adultColor = Colors.grey;
        _seniorColor = Colors.grey;
      } else if (age < 20) {
        ageGroup = 'joven';
        _childColor = Colors.grey;
        _teenColor = Color.fromARGB(255, 192, 189, 255);
        _adultColor = Colors.grey;
        _seniorColor = Colors.grey;
      } else if (age < 65) {
        ageGroup = 'adulto';
        _childColor = Colors.grey;
        _teenColor = Colors.grey;
        _adultColor = Color.fromARGB(255, 226, 255, 190);
        _seniorColor = Colors.grey;
      } else {
        ageGroup = 'anciano';
        _childColor = Colors.grey;
        _teenColor = Colors.grey;
        _adultColor = Colors.grey;
        _seniorColor = Color.fromARGB(255, 255, 213, 150);
      }

      setState(() {
        _message = 'Tienes $age años. Eres un $ageGroup.';
      });
    } else {
      print('Error al obtener datos de la API');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        // Wrap the Scaffold with SingleChildScrollView
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: 300,
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
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _predictAge,
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
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: EdgeInsets.symmetric(horizontal: 60),
                  children: [
                    IconContainer(icon: Icons.child_care, color: _childColor),
                    IconContainer(icon: Icons.school, color: _teenColor),
                    IconContainer(icon: Icons.work, color: _adultColor),
                    IconContainer(icon: Icons.elderly, color: _seniorColor),
                  ],
                ),
                SizedBox(height: 40),
                Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      _message,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconContainer({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
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
