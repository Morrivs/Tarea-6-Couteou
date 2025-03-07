import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic> _weatherData = {};
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.weatherbit.io/v2.0/current?lat=18.47186&lon=-69.89232&key=caec824d08624d62889b610014788a36&lang=es'));

      if (response.statusCode == 200) {
        setState(() {
          _weatherData = json.decode(response.body)['data'][0];
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load weather data';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _weatherData.isEmpty
            ? _errorMessage.isEmpty
                ? CircularProgressIndicator()
                : Text(_errorMessage, style: TextStyle(color: Colors.red))
            : WeatherInfo(weatherData: _weatherData),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherInfo({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    double temp = (weatherData['temp'] as num).toDouble();
    double precip = (weatherData['precip'] as num).toDouble();
    String description = weatherData['weather']['description'];
    String icon = weatherData['weather']['icon'];

    return SingleChildScrollView(
      child: Container(
        width: 300,
        padding: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 236, 236, 236),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://www.weatherbit.io/static/img/icons/$icon.png',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '$temp°C',
              style: TextStyle(
                  fontSize: 40, color: Color.fromARGB(255, 94, 94, 94)),
            ),
            SizedBox(height: 20),
            Container(
              width: 320,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$description',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 94, 94, 94)),
                  ),
                  Text(
                    'Precipitaciones: $precip%',
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 94, 94, 94)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
