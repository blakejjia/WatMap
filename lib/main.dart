import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watmap/frontend/pages/HomePage.dart';
import 'package:get_it/get_it.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:watmap/frontend/blocs/report_bloc/report_bloc.dart';
import 'backend/db/database.dart';
import 'backend/repositories/building.dart';
import 'backend/repositories/location.dart';
import 'backend/repositories/path.dart';
import 'backend/services/SupaService.dart';
import 'frontend/blocs/map_bloc/map_bloc.dart';

final getIt = GetIt.instance;

void main() async {
  await init();
  runApp(const MyApp());
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "config/properties.env");
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getApplicationDocumentsDirectory()).path,
    ),
  );

  await Supabase.initialize(
    anonKey: dotenv.env['API_KEY'] ?? "",
    url: dotenv.env['SUPABASE_URL'] ?? "",
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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            behavior: SnackBarBehavior.floating,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            contentTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer, fontSize: 15),
          ),

        ),
        debugShowCheckedModeBanner: false,
        home: const Homepage(),
      ),
    );
  }
}
