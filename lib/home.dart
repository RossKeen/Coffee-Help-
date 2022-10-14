import 'package:flutter/material.dart';

import 'favouriteDrinks.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FavouriteDrinks(),
      ],
    );
  }
}
