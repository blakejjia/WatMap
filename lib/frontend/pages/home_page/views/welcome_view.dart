import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watmap/frontend/blocs/settings_bloc/settings_bloc.dart';
import 'package:watmap/frontend/pages/home_page/animations/delay_fade_in.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 3) {
      setState(() => _currentPage += 1);
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = List.generate(4, (index) => _buildPage(context, index));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: pages[_currentPage]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (index) => GestureDetector(
              onTap: () => setState(() => _currentPage = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        return PageContent(
          icon: Icons.map,
          title: "Welcome to WatMap!",
          description:
              "Discover a smarter way to navigate and explore your waterloo.",
          onNext: _nextPage,
          onPrev: _prevPage,
        );
      case 1:
        return PageContent(
          icon: Icons.explore,
          title: "Explore with Confidence",
          description:
              "Find the best routes, tunnels, and hidden tunnels effortlessly.",
          onNext: _nextPage,
          onPrev: _prevPage,
        );
      case 2:
        return PageContent(
          icon: Icons.add_location_alt_rounded,
          title: "Powerful Reporting",
          description:
              "Easily report correct routes or suggest modifying ones to improve the WatMap experience for everyone.",
          onNext: _nextPage,
          onPrev: _prevPage,
        );
      case 3:
        return PageContent(
          icon: Icons.celebration,
          title: "Get Started",
          description:
              "Grant location access to unlock the full potential of WatMap and start your journey today.",
          onPrev: _prevPage,
          onNext: () {
            context.read<SettingsBloc>().add(NotNewUsr());
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class PageContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onNext;
  final VoidCallback? onPrev;

  const PageContent({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onNext,
    this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null) {
          if (details.primaryVelocity! > 0) {
            // Swipe right
            if (onPrev != null) {
              onPrev!();
            }
          } else if (details.primaryVelocity! < 0) {
            // Swipe left
            if (onNext != null) {
              onNext!();
            }
          }
        }
      },
      child: Stack(
        children: [
          // cover for guestures
          Container(
            color: Colors.transparent,
            height: double.infinity,
            width: double.infinity,
          ),

          // next button
          Positioned(
            bottom: 40,
            right: 30,
            child: DelayFadeInEffect(
              delayAmount: 0.5,
              duration: const Duration(milliseconds: 1500),
              child: InkWell(
                key: ValueKey(title),
                onTap: onNext,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primaryContainer,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                child: child,
              );
            },
            child: Center(
              child: Column(
                key: ValueKey(title),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.color?.withAlpha(170),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
