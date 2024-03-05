import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/counter_info.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  static const counterKey = 'counter';
  static const counterInfoKey = 'counterInfo';
  int _counter = 0;

  @override
  void initState() {
    _initCounter();
    _printCounterInfo();
    super.initState();
  }

  Future _printCounterInfo() async {
    final counterInfo = await _getCounterInfo();
    
    if(counterInfo == null) return null;

    print('==========');
    print('value: ${counterInfo.value}');
    print('lastUpdate: ${counterInfo.lastUpdate}');
    print('userName: ${counterInfo.userName}');
    print('==========');
  }

  Future _initCounter() async {
    _counter = await _getCounter();
    setState(() {});
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });

    await _setCounter();
    await _setCounterInfo();
  }

  Future _setCounter() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt(counterKey, _counter);
  }

  Future _setCounterInfo() async {
    var prefs = await SharedPreferences.getInstance();
    final counterInfo = CounterInfo(
      value: _counter,
      lastUpdate: DateTime.now(),
      userName: 'Alex',
    );
    prefs.setString(counterInfoKey, json.encode(counterInfo));
  }

  Future<int> _getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt(counterKey) ?? 0;
  }
  
  Future<CounterInfo?> _getCounterInfo() async {
    var prefs = await SharedPreferences.getInstance();
    final counterInfo = prefs.getString(counterInfoKey);
    if (counterInfo == null) return null;
    return CounterInfo.fromJson(json.decode(counterInfo));
  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
