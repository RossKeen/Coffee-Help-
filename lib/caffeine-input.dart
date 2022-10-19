import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaffeineWidget extends StatefulWidget {
  String goal;
  CaffeineWidget(this.goal);
  @override
  _CaffeineWidgetState createState() => _CaffeineWidgetState();
}

class _CaffeineWidgetState extends State<CaffeineWidget> {
  void changeGoal(value) {
    final user =
        FirebaseFirestore.instance.collection('users').doc('test-user');
    user.update({'caffeine-goal': int.parse(value)});
    setState(() {
      widget.goal = value;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(padding: EdgeInsets.all(0.1)),
          Text('Derek McBean 3rd'),
          Text(
            'Limit: ${widget.goal}mg',
            style: TextStyle(fontSize: 40, fontFamily: 'helvetica'),
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

  Widget CaffeineInput() => Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onSubmitted: (value) => changeGoal(value),
          cursorColor: Colors.black,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(20),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.brown)),
            labelText: 'Set a new caffeine limit!',
            labelStyle: TextStyle(color: Colors.brown, fontSize: 20),
            suffixText: 'mg',
            suffixStyle: TextStyle(fontSize: 20),
            prefixIcon: Icon(
              Icons.coffee,
              color: Colors.brown,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.done,
          scrollPadding: EdgeInsets.all(32),
        ),
      );
}

Widget _buildPopupDialog(BuildContext context) {
  void handlePress() {
    FirebaseFirestore.instance
        .collection('users')
        .doc('test-user')
        .update({'current-caffeine': 0});
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
