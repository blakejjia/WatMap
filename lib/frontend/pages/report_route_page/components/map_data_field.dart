part of '../report_route_page.dart';

class MapDataField extends StatelessWidget {
  const MapDataField({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController buildingAController = TextEditingController();
    final TextEditingController floorAController = TextEditingController();
    final TextEditingController buildingBController = TextEditingController();
    final TextEditingController floorBController = TextEditingController();
    final TextEditingController pathTypeController = TextEditingController();
    final GlobalKey<FormFieldState<String>> floorAKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> floorBKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormFieldState<String>> pathTypeKey =
        GlobalKey<FormFieldState<String>>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      key: formKey,
      child: Column(
        children: [
          /// LocationA ----------------------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("BuildingA:", style: TextStyle(fontSize: 20)),
            ),
          ),
          TextFormField(
            controller: buildingAController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter buildingA',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'BuildingA is required';
              }
              return null;
            },
          ),

          /// Floor A ----------------------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("FloorA:", style: TextStyle(fontSize: 20)),
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select FloorA',
            ),
            items: List.generate(
              8,
              (index) => DropdownMenuItem(
                value: index.toString(),
                child: Text('Floor $index'),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                floorAController.text = value;
              }
            },
            key: floorAKey,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'FloorA is required';
              }
              return null;
            },
          ),

          /// Location B ----------------------------
          Padding(padding: const EdgeInsets.all(30.0), child: Divider()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("BuildingB:", style: TextStyle(fontSize: 20)),
            ),
          ),
          TextFormField(
            controller: buildingBController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter buildingB',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'BuildingB is required';
              }
              return null;
            },
          ),

          /// Floor B ----------------------------
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("FloorB:", style: TextStyle(fontSize: 20)),
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select FloorB',
            ),
            items: List.generate(
              8,
              (index) => DropdownMenuItem(
                value: index.toString(),
                child: Text('Floor $index'),
              ),
            ),
            onChanged: (value) {
              if (value != null) {
                floorBController.text = value;
              }
            },
            key: floorBKey,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'FloorB is required';
              }
              return null;
            },
          ),

          /// PATH TYPE ----------------------------
          Padding(padding: const EdgeInsets.all(30.0), child: Divider()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Path Type:", style: TextStyle(fontSize: 20)),
            ),
          ),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Select Path Type',
            ),
            items: [
              DropdownMenuItem(value: 'TUNNEL', child: Text('TUNNEL')),
              DropdownMenuItem(value: 'BRIDGE', child: Text('BRIDGE')),
              DropdownMenuItem(value: 'INSIDE', child: Text('INSIDE')),
              DropdownMenuItem(value: 'OUTSIDE', child: Text('OUTSIDE')),
            ],
            onChanged: (value) {
              if (value != null) {
                pathTypeController.text = value;
              }
            },
            key: pathTypeKey,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Path Type is required';
              }
              return null;
            },
          ),

          /// Submit ----------------------------
          Padding(padding: const EdgeInsets.all(30.0), child: Divider()),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                // Perform the submit action
                // floorAController.clear();
                // floorAKey.currentState?.reset();
                // buildingBController.clear();
                // floorBController.clear();
                // floorBKey.currentState?.reset();
                // pathTypeController.clear();
                // pathTypeKey.currentState?.reset();

                context.read<ReportBloc>().add(
                  ReportRouteEvent(
                    buildingA: buildingAController.text,
                    floorA: floorAController.text,
                    buildingB: buildingBController.text,
                    floorB: floorBController.text,
                    pathType: pathTypeController.text,
                  ),
                );
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
