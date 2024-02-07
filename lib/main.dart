import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quizeapp/display.dart';
import 'package:quizeapp/home.dart';

import 'package:quizeapp/models/questionmodel.dart';
import 'package:quizeapp/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<QuestionDetails>(QuestionDetailsAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScrn(),
      debugShowCheckedModeBanner: false,
    );
  }
}
