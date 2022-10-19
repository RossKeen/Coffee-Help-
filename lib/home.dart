import 'package:flutter/material.dart';

import 'favouriteDrinks.dart';
import 'progressBar.dart';
import 'derek.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FavouriteDrinks(),
      ],
    );
  }
}
