import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import '../../settings_page/settings_page.dart';

const double actionSize = 55;

class HomePageActions extends StatelessWidget {
  const HomePageActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [_ActionWidget()],
          ),
        ),
      ],
    );
  }
}

class _ActionWidget extends StatefulWidget {
  const _ActionWidget({super.key});

  @override
  State<_ActionWidget> createState() => _ActionWidgetState();
}

class _ActionWidgetState extends State<_ActionWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Weather? _previousWeather;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getColor(Weather weather) {
    return Theme.of(context).colorScheme.surface;
  }

  IconData _getIcon(Weather weather) {
    switch (weather) {
      case Weather.snowy:
        return Icons.snowing;
      case Weather.sunny:
        return Icons.sunny;
    }
  }

  String _getText(Weather weather) {
    switch (weather) {
      case Weather.snowy:
        return "Snowy";
      case Weather.sunny:
        return "Sunny";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsBloc, SettingsState>(
      listenWhen: (prev, curr) => prev.weather != curr.weather,
      listener: (_, state) {
        _controller.forward(from: 0);
      },
      builder: (context, state) {
        final weather = state.weather;

        return TweenAnimationBuilder<Color?>(
          tween: ColorTween(
            begin: _getColor(_previousWeather ?? weather),
            end: _getColor(weather),
          ),
          duration: const Duration(milliseconds: 500),
          builder: (context, color, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    context.read<SettingsBloc>().add(ChangeWeather(weather));
                  },
                  child: Container(
                    width: actionSize,
                    height: actionSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: color,
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder: (child, animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: Column(
                          key: ValueKey(weather), // Add key to the Column
                          mainAxisSize: MainAxisSize.min, // Shrink the column
                          children: [
                            Icon(_getIcon(weather), grade: 1),
                            Text(
                              _getText(weather),
                              style: TextStyle(
                                color:
                                    Theme.of(
                                      context,
                                    ).colorScheme.onPrimaryContainer,
                                fontWeight: FontWeight.bold,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0), // Spacing between the two widgets
                Container(
                  width: actionSize,
                  height: actionSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.settings_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
