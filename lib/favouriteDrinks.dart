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
  int caffeineState = 0;
  var db = FirebaseFirestore.instance;
  void handleTap(caffeine) {
    var getDrinkId = db
        .collection('users')
        .where('id', isEqualTo: 'test-user')
        .get()
        .then((event) {
      var currentCaffeine = event.docs[0].data()['current-caffeine'];
      return currentCaffeine;
    }).then((currentCaffeine) {
      setState(() {
        caffeineState = currentCaffeine + caffeine;
      });
      db
          .collection('users')
          .doc("test-user")
          .update({'current-caffeine': currentCaffeine + caffeine});
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
                          onTap: () => handleTap(drink['caffeine']),
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
