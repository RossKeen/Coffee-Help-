import 'package:flutter/material.dart';
import 'profilePic.dart';

class Username extends StatelessWidget {
  final username;
  Username(this.username);
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        username,
        style: TextStyle(fontSize: 22),
        textAlign: TextAlign.left,
      ),
    );
  }
}
