import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  DrinkCard(this.drink);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          drink['name'].toString() + ' ',
          style: TextStyle(fontSize: 20),
        ),
        Text(drink['caffeine'].toString() + 'mg'),
        FavouriteButton(),
      ]),
    );
  }
}
