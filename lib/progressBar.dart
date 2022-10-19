import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar();
  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  _ProgressBarState();

  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance;

    var user = db.collection('users').get().then((data) {
      return data.docs[0].data();
    });

    return FutureBuilder(
        future: user,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            int curr_caffeine = snapshot.data['current-caffeine'];
            int caffeine_goal = snapshot.data['caffeine-goal'];

            double progress = curr_caffeine / caffeine_goal;

            caffeineLimit() {
              if (progress < 1) {
                return Text("${(progress * 100).round()}%",
                    style: TextStyle(color: Colors.white));
              } else {
                return Text(
                  "OVER THE LIMIT!",
                  style: TextStyle(color: Colors.white),
                );
              }
            }

            generatePercent() {
              if (progress < 1) {
                double percent = progress;
                return percent;
              } else {
                double percent = 1;
                return percent;
              }
            }

            currentProgressColor() {
              if (progress > 0.6 && progress < 0.8) {
                return Color.fromARGB(255, 224, 92, 59);
              }
              if (progress >= 0.85) {
                return Color.fromARGB(255, 140, 19, 10);
              } else {
                return Color.fromARGB(255, 132, 100, 25);
              }
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: LinearPercentIndicator(
                    backgroundColor: Color.fromARGB(255, 203, 202, 171),
                    width: 250.0,
                    lineHeight: 40.0,
                    leading: new Text("0mg"),
                    trailing: new Text("${caffeine_goal}mg"),
                    percent: generatePercent(),
                    barRadius: const Radius.circular(16),
                    center: caffeineLimit(),
                    progressColor: currentProgressColor(),
                    animateFromLastPercent: true,
                  ),
                ),
              ],
            );
          } else {
            return Text('lol');
          }
        }));
  }
}
