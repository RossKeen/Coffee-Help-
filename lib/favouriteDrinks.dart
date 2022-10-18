import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_help/progressBar.dart';
import 'package:flutter/material.dart';

class FavouriteDrinks extends StatefulWidget {
  const FavouriteDrinks({super.key});

  @override
  State<FavouriteDrinks> createState() => _FavouriteDrinksState();
}

class _FavouriteDrinksState extends State<FavouriteDrinks> {
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;
    void handleTap(caffeine, currentCaffeine) {
      db
          .collection('users')
          .doc("test-user")
          .update({'current-caffeine': caffeine + currentCaffeine}).then((e) {
        setState(() {});
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
          for (Map drink in drinksList) {
            if (drink['favourited'] && favouritedDrinks.length < 5) {
              favouritedDrinks.add(drink);
            }
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            key: UniqueKey(),
            children: [
              ProgressBar(user['current-caffeine'], user['caffeine-goal']),
              Column(
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
                              onTap: () => {
                                    handleTap(drink['caffeine'],
                                        user['current-caffeine'])
                                  },
                              title: Row(children: [
                                Icon(
                                  Icons.local_cafe,
                                  color: Colors.brown[300],
                                ),
                                Text(' ${drink['name']}')
                              ]));
                        }).toList()),
            ],
          );
        } else {
          return Text('Loading...');
        }
      }),
    );
  }
}
