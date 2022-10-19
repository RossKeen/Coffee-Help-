import 'package:flutter/material.dart';

class Derek extends StatefulWidget {
  final int currCaffeine;
  final int caffeineGoal;
  Derek(this.currCaffeine, this.caffeineGoal);

  @override
  State<Derek> createState() => _DerekState(currCaffeine, caffeineGoal);
}

class _DerekState extends State<Derek> {
  final int currCaffeine;
  final int caffeineGoal;

  _DerekState(this.currCaffeine, this.caffeineGoal);

  @override
  Widget build(BuildContext context) {
    double progress = currCaffeine / caffeineGoal;

    return progress >= 0.85
        ? Image.asset('assets/images/fast.gif')
        : progress <= 0.6
            ? Image.asset('assets/images/slow.gif')
            : Image.asset('assets/images/medium.gif');
  }
}
