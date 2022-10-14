import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  final db;
  final drink_id;
  final bool drink_favourited;
  FavouriteButton(this.db, this.drink_id, this.drink_favourited);

  @override
  State<FavouriteButton> createState() =>
      _FavouriteButtonState(db, drink_id, drink_favourited);
}

class _FavouriteButtonState extends State<FavouriteButton> {
  bool _favourited;
  final drink_id;
  final db;
  _FavouriteButtonState(this.db, this.drink_id, this._favourited);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _favourited == true ? _favourited = false : _favourited = true;
        });
        db
            .collection('drinks')
            .doc(drink_id)
            .update({'favourited': _favourited});
      },
      icon: Icon(
        Icons.star,
        color: _favourited ? Colors.yellow : Colors.grey,
      ),
    );
  }
}

//line 17, write an if statement when pressed change to gold else keep it gray
