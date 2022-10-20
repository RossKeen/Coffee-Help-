import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_help/customDrinkForm.dart';
import 'package:coffee_help/progressBar.dart';
import 'package:flutter/material.dart';

import './drinkCard.dart';

class Drinks extends StatefulWidget {
  const Drinks({super.key});

  @override
  _DrinksState createState() => _DrinksState();
}

class _DrinksState extends State<Drinks> {
  bool drinkAdded = false;
  int lastDrinkCaffeine = 0;
  var db = FirebaseFirestore.instance;
  void _parentReload() {
    setState(() {});
  }

  void _changeDrinkBool(drinkBool, caffeine) {
    setState(() {
      drinkAdded = drinkBool;
      lastDrinkCaffeine = caffeine;
    });
  }

  void handlePress() {
    db.collection('users').get().then((event) {
      return event.docs[0].data()['current-caffeine'];
    }).then((cCaffeine) {
      db
          .collection('users')
          .doc('test-user')
          .update({'current-caffeine': cCaffeine - lastDrinkCaffeine});
    }).then((e) {
      setState(() {
        drinkAdded = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var drink = db.collection('drinks').get().then((event) {
      var drinks = [];
      for (var doc in event.docs) {
        drinks.add(doc.data());
      }
      return drinks;
    });
    var user = db.collection('users').get().then((event) {
      return event.docs[0].data();
    });
    return FutureBuilder(
      future: Future.wait([drink, user]),
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var drinksList = snapshot.data[0];
          var user = snapshot.data[1];
          return Column(
            key: UniqueKey(),
            children: [
              CustomDrinkForm(parentReload: _parentReload),
              ProgressBar(user['current-caffeine'], user['caffeine-goal']),
              Expanded(
                child: ListView(shrinkWrap: true, children: [
                  ...drinksList.map((drink) {
                    return DrinkCard(
                      db,
                      drink,
                      _changeDrinkBool,
                      _parentReload,
                    );
                  }).toList()
                ]),
              ),
              Container(
                  child: drinkAdded
                      ? ElevatedButton(
                          onPressed: () {
                            handlePress();
                          },
                          child: Text('Undo last drink'),
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(204, 102, 0, 1)))
                      : Text('')),
            ],
          );
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
