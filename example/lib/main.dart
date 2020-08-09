import 'dart:math';

import 'package:flutter/material.dart';
import 'package:suspense/suspense.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Suspense Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Suspense Flutter Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final rng = Random();
  Stream<int> _stream;

  @override
  void initState() {
    super.initState();

    _stream = Stream<int>.periodic(
      Duration(seconds: 1),
      (_) => rng.nextInt(10000),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Suspense<int>.stream(
          stream: _stream,
          fallback: CircularProgressIndicator(),
          builder: (data) => Text('Result: $data'),
          errorBuilder: (error) => Text('Uh oh! it didn\'t work: $error'),
        ),
      ),
    );
  }
}
