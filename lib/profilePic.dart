import 'package:coffee_help/caffeine-input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfilePic extends StatefulWidget {
  final String goal;
  ProfilePic(this.goal);

  @override
  State<ProfilePic> createState() => _ProfilePicState(goal);
}

class _ProfilePicState extends State<ProfilePic> {
  final String goal;
  _ProfilePicState(this.goal);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              width: 400,
              color: Colors.brown[200],
              child: Center(
                child: Image.asset('assets/images/beans2.png'),
              ),
            ),
            Expanded(
              child: Container(child: Center(child: CaffeineWidget(goal))),
            ),
          ],
        ),
        Positioned(
          top: 175,
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3))
                ],
                border: Border.all(width: 2, color: Colors.black)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/derek1.png',
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
      ],
    );

    // SizedBox(height: 80, child: Image.asset('assets/images/pucky.jpg'));
  }
}
