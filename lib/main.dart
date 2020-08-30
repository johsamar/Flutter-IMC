import 'package:flutter/material.dart';
import 'package:kalkulator_imc/pages/principal_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Kalkulator',
      debugShowCheckedModeBanner: false,
      home: PrincipalPage(),
    );
  }
}
