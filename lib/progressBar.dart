import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProgressBar extends StatefulWidget {
  @override
  _ProgressBarState createState() => _ProgressBarState();
}



class _ProgressBarState extends State<ProgressBar> {


  

double progress = double.parse(currentCaffeine)/double.parse(goal);
double percent = 0;
  currentProgressColor() {
    if (progress >= 0.7 && progress < 0.8) {
      return Colors.orange;
    }
    if(progress >= 0.8){
      return Colors.red;
    }
    else{
      return Colors.green;
    }
  }
  caffeineLimit () {
    if (progress < 1) {
      percent = progress;
      return Text("${progress * 100}%");

    } else {
      percent = 1;
      return Text("Caffeine limit reached!");

    }
  }
  @override 
  Widget build(BuildContext context) {
    return  Padding(
              padding: EdgeInsets.all(20.0),
              child: new LinearPercentIndicator(
                width: 170.0,
                animation: true,
                animationDuration: 1000,
                lineHeight: 20.0,
                leading: new Text("0mg"),
                trailing: new Text("400mg"),
                percent: percent,
                barRadius: const Radius.circular(16),
                center: caffeineLimit() ,
                progressColor: currentProgressColor(),
              
                
              ),
            );
  }

}

String goal = '0';
  String currentCaffeine = '0';
