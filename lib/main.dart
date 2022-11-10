import 'dart:math';

import 'package:envidual_coding_challenge/db/levels_database.dart';
import 'package:envidual_coding_challenge/model/level.dart';
import 'package:envidual_coding_challenge/start_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Envidual',
      theme: ThemeData(
        primaryColor: const Color(0xff1e8593),
      ),
      initialRoute: () {
        return '/start';
      }(),
      routes: {
        '/start': (context) => StartPage(),
      },
    );
  }
}
