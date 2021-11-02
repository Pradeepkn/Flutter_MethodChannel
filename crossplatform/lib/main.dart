import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Message',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Native Message'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    static const platform = MethodChannel('samples.flutter.dev/crossplatform');

  String _numberOfSteps = '0';

  Future<void> _getStepsCount() async {
    String stepsCount;
    try {
      final int result = await platform.invokeMethod('getStepsCount');
      stepsCount = 'Steps Counts are $result';
    } on PlatformException catch (e) {
      stepsCount = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _numberOfSteps = stepsCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('Get Number of Steps Count'),
              onPressed: _getStepsCount,
            ),
            Text(_numberOfSteps),
          ],
        ),
      ),
    );
  }
}
