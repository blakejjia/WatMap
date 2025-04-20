import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/pages/map_page/map_page.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/settings_page/settings_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[MapPage(), SettingsPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WATMAP'),
        actions: [
          BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<SettingsBloc>().add(ChangeWeather(state.weather));
                },
                icon: Icon(
                  state.weather == Weather.snowy
                      ? Icons.snowing
                      : state.weather == Weather.sunny
                      ? Icons.sunny
                      : Icons.cloud,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        // listen for db status, to tell use
        listener: (context, state) {
          if (state.isBuilt == false) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.lastMapRefreshTime),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
