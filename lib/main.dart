import 'package:flutter/material.dart';
import 'package:watmap/pages/home_page.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'data/db/database.dart';

void main() {
  final db = Database(NativeDatabase.memory());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
