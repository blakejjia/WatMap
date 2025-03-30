part of '../map_page.dart';

class NewUserMapView extends StatelessWidget {
  const NewUserMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Please refresh the map to get the latest data",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
