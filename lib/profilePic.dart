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
              height: 200,
              color: Color.fromARGB(255, 150, 139, 122),
              child: Center(
                child: Image.asset('assets/images/nature.jpg'),
              ),
            ),
            Expanded(
              child: Container(child: Center(child: CaffeineWidget(goal))),
            ),
          ],
        ),
        Positioned(
          top: 150,
          child: Container(
            height: 100,
            width: 100,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
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
