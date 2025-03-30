part of '../map_page.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {});
            },
            children: [
              _buildPage(
                context,
                icon: Icons.map,
                title: "Welcome to WatMap!",
                description:
                    "Discover a smarter way to navigate and explore UW.",
              ),
              _buildPage(
                context,
                icon: Icons.explore,
                title: "Explore with Confidence",
                description:
                    "Find the best routes, tunnels, and hidden tunnels effortlessly.",
              ),
              _buildPage(
                context,
                icon: Icons.add_location_alt_rounded,
                title: "Powerful Reporting",
                description:
                    "Easily report correct routes or suggest modifying ones to improve the WatMap experience for everyone.",
              ),
              _buildPage(
                context,
                icon: Icons.start,
                title: "Get Started",
                description:
                    "Grant location access to unlock the full potential of WatMap and start your journey today.",
                button: ElevatedButton(
                  onPressed: () {
                    getIt<SettingsBloc>().add(RetriveDataEvent());
                  },
                  child: Text("getStarted"),
                ),
              ),
            ],
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: 4,
          effect: WormEffect(
            dotHeight: 8.0,
            dotWidth: 8.0,
            activeDotColor: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPage(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    Widget? button,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 80, color: Theme.of(context).colorScheme.primary),
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if (button != null) button,
      ],
    );
  }
}
