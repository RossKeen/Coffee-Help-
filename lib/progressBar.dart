import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBar extends StatefulWidget {
  final caffeineState;
  final caffeineGoalState;

  ProgressBar(this.caffeineState, this.caffeineGoalState);
  @override
  _ProgressBarState createState() =>
      _ProgressBarState(caffeineState, caffeineGoalState);
}

class _ProgressBarState extends State<ProgressBar> {
  final caffeineState;
  final caffeineGoalState;

  _ProgressBarState(this.caffeineState, this.caffeineGoalState);

  @override
  Widget build(BuildContext context) {
    double progress = caffeineState / caffeineGoalState;

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

    return Row(
      key: UniqueKey(),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: LinearPercentIndicator(
            key: UniqueKey(),
            backgroundColor: Color.fromARGB(255, 218, 218, 218),
            //fillColor: Colors.blueAccent,
            width: 250.0,
            lineHeight: 40.0,
            leading: new Text("0mg"),
            trailing: new Text("${caffeineGoalState}mg"),
            percent: generatePercent(),
            barRadius: const Radius.circular(16),
            center: caffeineLimit(),
            progressColor: currentProgressColor(),
            animateFromLastPercent: true,
          ),
        ),
      ],
    );
  }
}
