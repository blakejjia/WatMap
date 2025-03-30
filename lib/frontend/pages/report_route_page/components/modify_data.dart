// part of '../report_route_page.dart';

// class ModifyData extends StatefulWidget {
//   final MyPath path;
//   const ModifyData({super.key, required this.path});

//   @override
//   State<ModifyData> createState() => _ModifyDataState();
// }

// class _ModifyDataState extends State<ModifyData> {
//   final _buildingAController = TextEditingController();
//   final _floorAController = TextEditingController();
//   final _buildingBController = TextEditingController();
//   final _floorBController = TextEditingController();
//   final _pathTypeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _buildingAController.text = widget.path.buildingA;
//     _floorAController.text = widget.path.floorA.toString();
//     _buildingBController.text = widget.path.buildingB;
//     _floorBController.text = widget.path.floorB.toString();
//     _pathTypeController.text = widget.path.pathType;
//   }

//   @override
//   void dispose() {
//     _buildingAController.dispose();
//     _floorAController.dispose();
//     _buildingBController.dispose();
//     _floorBController.dispose();
//     _pathTypeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Modify Data')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _buildingAController,
//               decoration: InputDecoration(labelText: 'Building A'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Building A';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _floorAController,
//               decoration: InputDecoration(labelText: 'Floor A'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Floor A';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _buildingBController,
//               decoration: InputDecoration(labelText: 'Building B'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Building B';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _floorBController,
//               decoration: InputDecoration(labelText: 'Floor B'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Floor B';
//                 }
//                 return null;
//               },
//             ),
//             TextFormField(
//               controller: _pathTypeController,
//               decoration: InputDecoration(labelText: 'Path Type'),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter Path Type';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 final newPath = MyPath(
//                   id: widget.path.id,
//                   buildingA: _buildingAController.text,
//                   floorA: int.parse(_floorAController.text),
//                   buildingB: _buildingBController.text,
//                   floorB: int.parse(_floorBController.text),
//                   pathType: _pathTypeController.text,
//                 );
//                 getIt_map<PathRepository>().updatePath(newPath);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
