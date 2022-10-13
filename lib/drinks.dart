import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import './drinkCard.dart';

class Drinks extends StatelessWidget {
  const Drinks({super.key});

  @override
  Widget build(BuildContext context) {
    var drinks = [];
    var db = FirebaseFirestore.instance;
    var drink = db.collection('drinks').get().then((event) {
      for (var doc in event.docs) {
        drinks.add(doc.data());
      }
    });
    return Text('lol');
  }
}
