import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatelessWidget {
  final Map<String, dynamic> drink;
  final db;
  DrinkCard(this.db, this.drink);

  @override
  Widget build(BuildContext context) {

    void handlePress(caffeine) {
      db.collection('users').get().then((data) {
         // Log.d('data', data.docs[0].data()['current-caffeine'].toString());
      }).then((cCaffeine) {
        db.collection('users').doc('test-user').update(
            {'current-caffeine': {cCaffeine + caffeine}});
      });
    }

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
        ElevatedButton(onPressed: () {handlePress(drink['caffeine']);}, child: Text('Add')),
        FavouriteButton(db, drink['id'], drink['favourited']),
      ]),
    );
  }
}
