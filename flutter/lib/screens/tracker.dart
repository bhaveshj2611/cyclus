import 'package:female_health/widgets/appBar.dart';
import 'package:flutter/material.dart';

class Tracker extends StatelessWidget {
  const Tracker({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(text: 'Ishika\'s Space'),
      appBar: buildAppBar(),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
