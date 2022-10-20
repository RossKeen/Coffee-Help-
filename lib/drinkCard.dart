import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatefulWidget {
  final Map<String, dynamic> drink;
  final db;
  final changeDrinkBool;
  DrinkCard(this.db, this.drink, this.changeDrinkBool);

  _DrinkCardState createState() => _DrinkCardState(db, drink, changeDrinkBool);
}

class _DrinkCardState extends State<DrinkCard> {
  final Map<String, dynamic> drink;
  final db;
  final changeDrinkBool;
  _DrinkCardState(this.db, this.drink, this.changeDrinkBool);

  @override
  Widget build(BuildContext context) {
    void handlePress(caffeine) {
      db.collection('users').get().then((data) {
        return data.docs[0].data()['current-caffeine'];
      }).then((cCaffeine) {
        db
            .collection('users')
            .doc('test-user')
            .update({'current-caffeine': cCaffeine + caffeine});
      }).then((e) {
        changeDrinkBool(true, caffeine);
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
        SizedBox(width: 50, child: Text(drink['caffeine'].toString() + 'mg')),
        ElevatedButton(
            style: OutlinedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(204, 102, 0, 1)),
            onPressed: () {
              handlePress(drink['caffeine']);
            },
            child: Text('Add')),
        FavouriteButton(db, drink['id'], drink['favourited']),
      ]),
    );
  }
}
