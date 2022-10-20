import 'package:flutter/material.dart';

import './favouriteButton.dart';

class DrinkCard extends StatefulWidget {
  final Map<String, dynamic> drink;
  final db;
  final changeDrinkBool;
  final parentReload;
  DrinkCard(this.db, this.drink, this.changeDrinkBool, this.parentReload);

  _DrinkCardState createState() =>
      _DrinkCardState(db, drink, changeDrinkBool, parentReload);
}

class _DrinkCardState extends State<DrinkCard> {
  final Map<String, dynamic> drink;
  final db;
  final changeDrinkBool;
  final parentReload;
  _DrinkCardState(this.db, this.drink, this.changeDrinkBool, this.parentReload);

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

    void handleDelete(drinkId) {
      db.collection('drinks').doc('${drinkId}').delete().then((e) {
        parentReload();
      });
    }

    return Card(
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 150,
              child: Text(
                drink['name'].toString() + ' ',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
                width: 50,
                child: drink['custom'] == true
                    ? OutlinedButton(
                        onPressed: () {
                          handleDelete(drink['id']);
                        },
                        child: Icon(
                          Icons.clear,
                          color: Colors.red[700],
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 232, 230, 198)),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(0)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)))),
                      )
                    : Text('')),
            SizedBox(
                width: 50, child: Text(drink['caffeine'].toString() + 'mg')),
            ElevatedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(204, 102, 0, 1)),
                onPressed: () {
                  handlePress(drink['caffeine']);
                },
                child: Text('Add')),
            FavouriteButton(db, drink['id'], drink['favourited']),
          ]),
        ],
      ),
    );
  }
}
