import 'package:flutter/material.dart';
import 'Exer_Unit.dart';
import 'authentification.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LOGIN',
      initialRoute: '/home',
      routes: {
        '/home': (context) => Authentification(),
        '/authen': (context) => ExerciceUnite(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
