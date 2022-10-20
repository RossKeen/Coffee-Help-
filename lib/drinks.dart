import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_help/progressBar.dart';
import 'package:flutter/material.dart';

import './drinkCard.dart';

class Drinks extends StatefulWidget {
  const Drinks({super.key});

  @override
  _DrinksState createState() => _DrinksState();
}

class _DrinksState extends State<Drinks> {
  @override
  Widget build(BuildContext context) {
    bool drinkAdded = false;
    int lastDrinkCaffeine = 0;
    var db = FirebaseFirestore.instance;
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
              ProgressBar(user['current-caffeine'], user['caffeine-goal']),
              Expanded(
                child: ListView(shrinkWrap: true, children: [
                  ...drinksList.map((drink) {
                    return DrinkCard(db, drink, setState);
                  }).toList()
                ]),
              ),
            ],
          );
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
