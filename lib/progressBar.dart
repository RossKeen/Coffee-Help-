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
    double percent = progress;
    currentProgressColor() {
      if (progress > 0.6 && progress < 0.8) {
        return Color.fromARGB(255, 224, 92, 59);
      }
      if (progress >= 0.8) {
        return Color.fromARGB(255, 140, 19, 10);
      } else {
        return Color.fromARGB(255, 132, 100, 25);
      }
    }

    caffeineLimit() {
      if (progress < 1) {
        percent = progress;
        return Text("${(progress * 100).round()}%", style: TextStyle(color: Colors.white));
      } else {
        percent = 1;
        return Text("OVER THE LIMIT!", style: TextStyle(color: Colors.white),);
      }
    }

    return Padding(
      padding: EdgeInsets.all(20.0),
      child: LinearPercentIndicator(
       
        backgroundColor: Color.fromARGB(255, 203, 202, 171),
        //fillColor: Colors.blueAccent,
        width: 250.0,
        lineHeight: 40.0,
        leading: new Text("0mg"),
        trailing: new Text("${caffeineGoalState}mg"),
        percent: percent,
        barRadius: const Radius.circular(16),
        center: caffeineLimit(),
        progressColor: currentProgressColor(),
        animateFromLastPercent: true,
        
        
      ),
    );
  }
}
