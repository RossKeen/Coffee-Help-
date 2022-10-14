import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import './navBar.dart';
import './drinks.dart';
import './home.dart';
import './profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      title: 'Flutter Demo',
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




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Drinks(),
    Profile()
  ];


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
