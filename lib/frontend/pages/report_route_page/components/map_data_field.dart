part of '../report_route_page.dart';

class MapDataField extends StatefulWidget {
  const MapDataField({super.key});

  @override
  _MapDataFieldState createState() => _MapDataFieldState();
}

class _MapDataFieldState extends State<MapDataField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController buildingAController = TextEditingController();
  final TextEditingController buildingBController = TextEditingController();

  String? floorA;
  String? floorB;
  String? pathType;

  @override
  void dispose() {
    buildingAController.dispose();
    buildingBController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              if (value.length > 3) {
                return 'Use building code indicated on map';
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
            value: floorA,
            items: List.generate(
              8,
              (index) => DropdownMenuItem(
                value: index.toString(),
                child: Text('Floor $index'),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'FloorA is required';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                floorA = value;
              });
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
              if (value.length > 3) {
                return 'Use building code indicated on map';
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
            value: floorB,
            items: List.generate(
              8,
              (index) => DropdownMenuItem(
                value: index.toString(),
                child: Text('Floor $index'),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'FloorB is required';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                floorB = value;
              });
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
            value: pathType,
            items: [
              DropdownMenuItem(value: 'TUNNEL', child: Text('TUNNEL')),
              DropdownMenuItem(value: 'BRIDGE', child: Text('BRIDGE')),
              DropdownMenuItem(value: 'INSIDE', child: Text('INSIDE')),
              DropdownMenuItem(value: 'OUTSIDE', child: Text('OUTSIDE')),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Path Type is required';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                pathType = value;
              });
            },
          ),

          /// Submit ----------------------------
          Padding(padding: const EdgeInsets.all(30.0), child: Divider()),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();

                context.read<ReportBloc>().add(
                  ReportRouteEvent(
                    buildingA: buildingAController.text,
                    floorA: floorA ?? '',
                    buildingB: buildingBController.text,
                    floorB: floorB ?? '',
                    pathType: pathType ?? '',
                  ),
                );

                // Clear the fields
                setState(() {
                  buildingAController.clear();
                  buildingBController.clear();
                  floorA = null;
                  floorB = null;
                  pathType = null;
                });
              }
            },
            child: Text("Submit"),
          ),
        ],
      ),
    );
  }
}
