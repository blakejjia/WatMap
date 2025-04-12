import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watmap/frontend/bloc/map_bloc.dart';
import 'package:watmap/frontend/pages/HomePage.dart';
import 'package:get_it/get_it.dart';
import 'package:watmap/frontend/pages/settings_page/Bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/report_route_page/bloc/report_bloc.dart';
import 'backend/db/database.dart';
import 'backend/repositories/building.dart';
import 'backend/repositories/location.dart';
import 'backend/repositories/path.dart';
import 'backend/services/SupaService.dart';

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

  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inljcmtqem9pY3JmeXd0bmdibnV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDQxMjY4OTQsImV4cCI6MjA1OTcwMjg5NH0.4uzt1ttVx70ZWmHR1M-I6YxbVPHE1f-bUL7UgoxUd6Q",
    url: 'https://ycrkjzoicrfywtngbnut.supabase.co'
  );
  final db = Supabase.instance.client;
  getIt.registerSingleton<SupaService>(SupaService(db));
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
