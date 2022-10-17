import 'package:flutter/material.dart';

import 'favouriteDrinks.dart';
import 'progressBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Image.network(
            'https://png.pngtree.com/png-clipart/20210418/original/pngtree-line-draft-doodle-smile-coffee-cup-png-image_6238196.jpg'),

        FavouriteDrinks(),
      ],
    );
  }

}


