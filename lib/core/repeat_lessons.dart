

import 'package:flutter/material.dart';

class RepeatLessons extends StatefulWidget {
  const RepeatLessons({super.key});

  @override
  State<RepeatLessons> createState() => _RepeatLessonsState();
}

class _RepeatLessonsState extends State<RepeatLessons> {

  // 4 dart
  String name = 'hello';
  int age = 24;
  double kg = 56.78;
  bool isSunny = true;
  // flutter
  Icon icon = const Icon(Icons.add);
  Widget container = Container(height: 100, width: 100,);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

    );
  }
}
