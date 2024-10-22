import 'package:flutter/material.dart';
import 'package:info_bitcoin/pages/Details/Details.dart';
import 'package:info_bitcoin/pages/HomeScreen/HomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informações Bitcoin',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => const DetailsPage(),
      },
    );
  }
}
