import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
import 'package:watmap/frontend/pages/HomePage.dart';
import 'package:get_it/get_it.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/components/report_route/bloc/report_bloc.dart';

import 'backend/db/database.dart';
import 'backend/pourdb/http.dart';
import 'backend/repositories/building.dart';
import 'backend/repositories/location.dart';
import 'backend/repositories/path.dart';

final getIt = GetIt.instance;

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  getIt.registerSingleton<MapHttpService>(
    MapHttpService('http://174.92.30.3/uwmap'),
  );
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<BuildingRepository>(
    BuildingRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<LocationRepository>(
    LocationRepository(getIt<AppDatabase>()),
  );
  getIt.registerSingleton<PathRepository>(PathRepository(getIt<AppDatabase>()));
  getIt.registerSingleton<SettingsBloc>(SettingsBloc());
  getIt.registerSingleton<MapBloc>(MapBloc());
  getIt.registerSingleton<ReportBloc>(ReportBloc());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MapBloc>(create: (context) => getIt<MapBloc>()),
        BlocProvider<SettingsBloc>(create: (context) => getIt<SettingsBloc>()),
        BlocProvider(create: (context) => ReportBloc()),
      ],
      child: MaterialApp(
        title: 'WatMap',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const Homepage(),
      ),
    );
  }
}
