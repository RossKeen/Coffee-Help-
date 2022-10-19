import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatefulWidget {
  final Map<String, dynamic> drink;
  final db;
  final setParentState;
  DrinkCard(this.db, this.drink, this.setParentState);

  _DrinkCardState createState() => _DrinkCardState(db, drink, setParentState);
}

class _DrinkCardState extends State<DrinkCard> {
  final Map<String, dynamic> drink;
  final db;
  final setParentState;
  _DrinkCardState(this.db, this.drink, this.setParentState);

  bool drinkAdded = false;
  @override
  void initState() {
    super.initState();
    drinkAdded = false;
  }

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
        setState(() {
          drinkAdded = true;
        });
        setParentState(() {});
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
        SizedBox(
          child: drinkAdded
              ? ElevatedButton(onPressed: () {}, child: Text('you did an add'))
              : Text(''),
        ),
        FavouriteButton(db, drink['id'], drink['favourited']),
      ]),
    );
  }
}
