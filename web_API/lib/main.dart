import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Weather App',
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: TextFormField(
          controller: uController,
          decoration: InputDecoration(
            hintText: 'Enter City Name',
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        WeatherInfo(cityName: uController.text),
                  ),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}

class WeatherInfo extends StatefulWidget {
  final String cityName;

  const WeatherInfo({Key? key, required this.cityName}) : super(key: key);

  @override
  _WeatherInfoState createState() => _WeatherInfoState();
}

class _WeatherInfoState extends State<WeatherInfo> {
  final String api =
      '962dcef5ab924f60b2b203802231409'; // Replace with your API key
  final String Url = 'https://api.weatherapi.com/v1/current.json';

  Map<String, dynamic>? weatherData;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final response =
        await http.get(Uri.parse('$Url?q=${widget.cityName}&key=$api'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        weatherData = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather Info'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: weatherData == null
            ? const CircularProgressIndicator()
            : WeatherDataDisplay(weatherData: weatherData!),
      ),
    );
  }
}

class WeatherDataDisplay extends StatelessWidget {
  final Map<String, dynamic> weatherData;

  const WeatherDataDisplay({Key? key, required this.weatherData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'City: ${weatherData['location']['name']}',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Text(
          'Temperature: ${weatherData['current']['temp_c']}°C',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 30),
        Text(
          'Condition: ${weatherData['current']['condition']['text']}',
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
