import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_help/progressBar.dart';
import 'package:flutter/material.dart';

import './derek.dart';

class FavouriteDrinks extends StatefulWidget {
  const FavouriteDrinks({super.key});

  @override
  State<FavouriteDrinks> createState() => _FavouriteDrinksState();
}

class _FavouriteDrinksState extends State<FavouriteDrinks> {
  late int caffeineState;
  late int goalState;
  bool drinkAdded = false;
  int lastCaffeine = 0;

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    void handleTap(caffeine, currentCaffeine) {
      db
          .collection('users')
          .doc("test-user")
          .update({'current-caffeine': caffeine + currentCaffeine}).then((e) {
        setState(() {
          drinkAdded = true;
          lastCaffeine = caffeine;
        });
      });
    }

    void handleUndo(caffeine, currentCaffeine) {
      db
          .collection('users')
          .doc("test-user")
          .update({'current-caffeine': currentCaffeine - caffeine}).then((e) {
        setState(() {
          drinkAdded = false;
          lastCaffeine = 0;
        });
      });
    }

    var getUser = db
        .collection('users')
        .where('id', isEqualTo: 'test-user')
        .get()
        .then((event) {
      return event.docs[0].data();
    });
    var drink = db.collection('drinks').get().then((event) {
      var drinks = [];
      for (var doc in event.docs) {
        drinks.add(doc.data());
      }
      return drinks;
    });

    return FutureBuilder(
      future: Future.wait([drink, getUser]),
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var favouritedDrinks = [];
          var drinksList = snapshot.data[0];
          var user = snapshot.data[1];
          caffeineState = user['current-caffeine'];
          goalState = user['caffeine-goal'];
          for (Map drink in drinksList) {
            if (drink['favourited']) {
              favouritedDrinks.add(drink);
            }
          }

          return Expanded(
            child: Column(
              key: UniqueKey(),
              children: [
                Derek(user['current-caffeine'], user['caffeine-goal']),
                ProgressBar(user['current-caffeine'], user['caffeine-goal']),
                Expanded(
                  child: ListView(
                      shrinkWrap: true,
                      children: favouritedDrinks.length == 0
                          ? [
                              const Text(
                                'Add a favourite drink',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    fontFamily: 'Helvetica'),
                              )
                            ]
                          : favouritedDrinks.map((drink) {
                              return ListTile(
                                  onTap: () => {
                                        handleTap(drink['caffeine'],
                                            user['current-caffeine'])
                                      },
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(children: [
                                          Icon(
                                            Icons.coffee,
                                            color: Colors.brown[600],
                                          ),
                                          Text(' ${drink['name']}'),
                                        ]),
                                        Icon(
                                          Icons.add_circle_outline,
                                          color:
                                              Color.fromARGB(255, 137, 85, 6),
                                        )
                                      ]));
                            }).toList()),
                ),
                SizedBox(
                    child: drinkAdded
                        ? ElevatedButton(
                            onPressed: () {
                              handleUndo(
                                  lastCaffeine, user['current-caffeine']);
                            },
                            child: Text('Undo last drink'),
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(204, 102, 0, 1)),
                          )
                        : Text('')),
              ],
            ),
          );
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
