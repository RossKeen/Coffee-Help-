import 'package:flutter/material.dart';

class Derek extends StatefulWidget {
  const Derek({super.key});

  @override
  State<Derek> createState() => _DerekState();
}

class _DerekState extends State<Derek> {
  bool toggle = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(seconds: 2),
        () => {
              setState(() {
                toggle ? toggle = false : toggle = true;
              })
            });

    return toggle
        ? Image.asset('assets/images/derek1.png')
        : Image.asset('assets/images/derek2.png');
  }
}
