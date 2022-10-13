import 'package:flutter/material.dart';

class DrinkCard extends StatelessWidget {
  final Map<String, Object> drink;
  DrinkCard(this.drink);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(children: [
        Text(drink['name'].toString() + ' '),
        Text(drink['caffeine'].toString() + 'mg'),
      ]),
    );
  }
}
