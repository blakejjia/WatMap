import 'package:flutter/material.dart';
import 'package:watmap/pages/home_page.dart';
import 'package:drift/native.dart';
import 'package:get_it/get_it.dart';

import 'data/db/database.dart';
import 'data/db/pourDb.dart';
import 'data/db/repositories/building.dart';
import 'data/db/repositories/location.dart';
import 'data/db/repositories/path.dart';

final getIt = GetIt.instance;

void main() {
  init();
  runApp(const MyApp());
}

void init() {
  getIt.registerSingleton<AppDatabase>(AppDatabase(NativeDatabase.memory()));
  getIt.registerSingleton<BuildingRepository>(BuildingRepository(getIt<AppDatabase>()));
  getIt.registerSingleton<LocationRepository>(LocationRepository(getIt<AppDatabase>()));
  getIt.registerSingleton<PathRepository>(PathRepository(getIt<AppDatabase>()));
  pourDb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WatMap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
