import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FavouriteDrinks extends StatefulWidget {
  const FavouriteDrinks({super.key});

  @override
  State<FavouriteDrinks> createState() => _FavouriteDrinksState();
}

class _FavouriteDrinksState extends State<FavouriteDrinks> {
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
          var favouritedDrinks = [];
          var drinksList = snapshot.data;
          for (Map drink in drinksList) {
            if (drink['favourited']) {
              favouritedDrinks.add(drink);
            }
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  favouritedDrinks.length > 0
                      ? ElevatedButton(
                          onPressed: () {},
                          child: Text(favouritedDrinks.length > 0
                              ? '${favouritedDrinks[0]['name']}'
                              : 'placeholder'))
                      : Icon(Icons.coffee),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(favouritedDrinks.length > 1
                          ? '${favouritedDrinks[1]['name']}'
                          : 'placeholder')),
                  ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.brown[300])),
                      child: Text(favouritedDrinks.length > 2
                          ? '${favouritedDrinks[2]['name']}'
                          : '')),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(favouritedDrinks.length > 3
                          ? '${favouritedDrinks[3]['name']}'
                          : 'placeholder')),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text(favouritedDrinks.length > 4
                          ? '${favouritedDrinks[4]['name']}'
                          : 'placeholder')),
                ],
              )
            ],
          );
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
