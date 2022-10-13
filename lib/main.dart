import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './navBar.dart';
import './drinks.dart';
import './home.dart';
import './profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final drinkData = [];

  @override
  Widget build(BuildContext context) {
    Future getDrinks() async {
      await db.collection('drinks').get();
    }

    return MaterialApp(
      theme: ThemeData(),
      title: 'Coffee, Help!',
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Drinks(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Coffee, Help!',
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: Colors.brown[300],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar:
          NavBar(selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }
}
