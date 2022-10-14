import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final db;
  DrinkCard(this.db, this.drink);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 150,
          child: Text(
            drink['name'].toString() + ' ',
            style: TextStyle(fontSize: 20),
          ),
        ),
        Text(drink['caffeine'].toString() + 'mg'),
        FavouriteButton(db, drink['id'], drink['favourited']),
      ]),
    );
  }
}
