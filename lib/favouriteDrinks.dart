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
            if (drink['favourited'] && favouritedDrinks.length < 5) {
              favouritedDrinks.add(drink);
            }
          }
          return Column(
              children: favouritedDrinks.length == 0
                  ? [
                      const Text(
                        'Add a favourite drink',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Helvetica'),
                      )
                    ]
                  : favouritedDrinks.map((drink) {
                      return ListTile(
                          onTap: () {},
                          title: Row(children: [
                            Icon(
                              Icons.local_cafe,
                              color: Colors.brown[300],
                            ),
                            Text(' ${drink['name']}')
                          ]));
                    }).toList());
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
