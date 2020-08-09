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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  final _calculation = Future.delayed(
    Duration(seconds: 2),
    () => Random().nextBool() ? 42 : throw 'unknown error',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Suspense<int>(
          future: _calculation,
          fallback: CircularProgressIndicator(),
          builder: (data) => Text('Result: $data'),
          errorBuilder: (error) => Text('Uh oh! it didn\'t work: $error'),
        ),
      ),
    );
  }
}
