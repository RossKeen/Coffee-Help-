import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './drinkCard.dart';

class Drinks extends StatelessWidget {
  const Drinks({super.key});

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    var drink = db.collection('drinks').get().then((event) {
      var drinks = [];
      for (var doc in event.docs) {
        drinks.add(doc.data());
      }
      return drinks;
    });
    return FutureBuilder(
      future: drink,
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var drinksList = snapshot.data;
          return ListView(children: [
            ...drinksList.map((drink) {
              return DrinkCard(db, drink);
            }).toList()
          ]);
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
