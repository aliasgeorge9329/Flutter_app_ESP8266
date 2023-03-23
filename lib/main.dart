import 'package:flutter/material.dart';
import 'package:get_data/home.dart';
import 'package:get_data/success.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GET DATA',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/":(context) => HomeSreen(),
          SuccessScreen.route_name:(context) => SuccessScreen(),
        },
        );
  }
}
