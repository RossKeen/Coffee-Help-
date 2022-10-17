import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Username(),
      CaffeineWidget(),
    ]);
  }
}

class Username extends StatefulWidget {
  _UsernameState createState() => _UsernameState();
}

class CaffeineWidget extends StatefulWidget {
  @override
  _CaffeineWidgetState createState() => _CaffeineWidgetState();
}

class _UsernameState extends State<Username> {
  String username = 'username';
  @override
  Widget build(BuildContext context) {
    var db = FirebaseFirestore.instance.collection('users');
    var user = db.get().then((event) {
      return event.docs[0].data();
    });
    return FutureBuilder(
      future: user,
      builder: ((context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          goal = snapshot.data['caffeine-goal'].toString();
          return Text(snapshot.data['username'],
              style: TextStyle(fontSize: 27));
        } else {
          return Text('Loading..');
        }
      }),
    );
  }
  //=>
}

dynamic goal = '...Loading';

class _CaffeineWidgetState extends State<CaffeineWidget> {
  var db = FirebaseFirestore.instance;
  void changeGoal(value) {
    final user = db.collection('users').doc('test-user');
    user.update({'caffeine-goal': value});
    setState(() {
      goal = value;
    });
  }

  void handlePress() {
    db.collection('users').doc('test-user').update({'current-caffeine': 0});
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          children: [
            Text('Goal: ${goal}mg'),
            CaffeineInput(),
            ElevatedButton(
                onPressed: () => {handlePress()},
                child: Text('Reset daily caffeine'))
          ],
        ),
      );

  Widget CaffeineInput() => TextField(
        onSubmitted: (value) => changeGoal(num.parse(value)),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'set a new caffeine goal!',
          prefixIcon: Icon(Icons.coffee),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        scrollPadding: EdgeInsets.all(32),
      );
}
