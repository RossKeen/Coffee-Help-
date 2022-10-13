import 'package:flutter/material.dart';

import './drinkCard.dart';

class Drinks extends StatefulWidget {
  const Drinks({super.key});
  // var db;
  // Drinks(this.db)

  @override
  State<Drinks> createState() => _DrinksState();
}

class _DrinksState extends State<Drinks> {
  // final drinksRef = db.collection('drinks');
  // final drinksData = const [
  //   {'name': 'Mocha', 'caffeine': 70, 'favourited': false},
  //   {'name': 'Espresso', 'caffeine': 60, 'favourited': false}
  // ];
  @override
  Widget build(BuildContext context) {
    return Text('data');
    // return Column(children: [...drinksData.map((drink) => DrinkCard(drink))]);
  }
}
