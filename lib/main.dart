import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
import 'package:watmap/frontend/pages/main_page/home_page.dart';
import 'package:get_it/get_it.dart';

import 'backend/db/database.dart';
import 'backend/pourdb/http.dart';
import 'backend/repositories/building.dart';
import 'backend/repositories/location.dart';
import 'backend/repositories/path.dart';

final getIt = GetIt.instance;

void main() {
  init();
  runApp(const MyApp());
}

void init() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<MapHttpService>(MapHttpService('http://174.92.30.3'));
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<BuildingRepository>(
    BuildingRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<LocationRepository>(
    LocationRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<PathRepository>(PathRepository(getIt<AppDatabase>()));
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
      home: BlocProvider(
        create: (context) => MapBloc(),
        child: const HomePage(),
      ),
    );
  }
}
