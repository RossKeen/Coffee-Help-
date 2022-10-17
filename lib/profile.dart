import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [Username()],
        ),
        CaffeineWidget(),
      ],
    );
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
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              snapshot.data['username'],
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.left,
            ),
          );
        } else {
          return Text('Loading..');
        }
      }),
    );
  }
  //=>
}

dynamic goal = '...Loading ';
var db = FirebaseFirestore.instance;

class _CaffeineWidgetState extends State<CaffeineWidget> {
  void changeGoal(value) {
    final user = db.collection('users').doc('test-user');
    user.update({'caffeine-goal': value});
    setState(() {
      goal = value;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            'Goal: ${goal}mg',
            style: TextStyle(fontSize: 25, fontFamily: 'helvetica'),
          ),
          CaffeineInput(),
          ElevatedButton(
              style:
                  OutlinedButton.styleFrom(backgroundColor: Colors.brown[400]),
              onPressed: () => {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context))
                  },
              child: Text('Reset daily caffeine'))
        ],
      );

  Widget CaffeineInput() => TextField(
        onSubmitted: (value) => changeGoal(num.parse(value)),
        cursorColor: Colors.black,
        decoration: const InputDecoration(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
          labelText: 'set a new caffeine goal!',
          labelStyle: TextStyle(color: Colors.brown),
          prefixIcon: Icon(
            Icons.coffee,
            color: Colors.brown,
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textInputAction: TextInputAction.done,
        scrollPadding: EdgeInsets.all(32),
      );
}

Widget _buildPopupDialog(BuildContext context) {
  void handlePress() {
    db.collection('users').doc('test-user').update({'current-caffeine': 0});
  }

  return AlertDialog(
      title: const Text(
          'Are you sure you want to clear your current caffeine intake?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("This action is irreversible..."),
        ],
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Close')),
        TextButton(
            onPressed: () =>
                {handlePress(), Navigator.pop(context, 'Clear anyway')},
            child: const Text('Clear anyway'))
      ]);
}
