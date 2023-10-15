import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _scale = 2.0;
  double _baseScale = 2.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: GestureDetector(
            onScaleStart: (details) {
              setState(() {
                _baseScale = _scale;
              });
            },
            onScaleUpdate: (details) {
              setState(() {
                _scale = (_baseScale * details.scale).clamp(2, 4);
              });
            },
            child: Transform.scale(
              scale: _scale,
              child: Image.network(
                  'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcRnWQRRg5TUWdRhqSAneMq1B4sXNR1bg3aMrRTUCuDVYyKlRhei0rY9ogb8AxtPXaSAfRM'),
            ),
          ),
        ));
  }
}
