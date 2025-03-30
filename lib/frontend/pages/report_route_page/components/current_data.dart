// part of '../report_route_page.dart';

// Widget _currentData(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       Navigator.of(
//         context,
//       ).push(MaterialPageRoute(builder: (context) => const CurrentData()));
//     },
//     child: Text("View Current Data"),
//   );
// }

// class CurrentData extends StatefulWidget {
//   const CurrentData({super.key});

//   @override
//   State<CurrentData> createState() => _CurrentDataState();
// }

// class _CurrentDataState extends State<CurrentData> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Current Data"),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {});
//             },
//             icon: Icon(Icons.refresh),
//           ),
//           IconButton(
//             onPressed: () {
//               getIt<PathRepository>().shareData();
//             },
//             icon: Icon(Icons.share),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<MyPath>>(
//         future: getIt<PathRepository>().readAllPaths(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Text('The database is empty.');
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 final path = snapshot.data![index];
//                 return ListTile(
//                   title: Text(
//                     '${path.buildingA} Lv.${path.floorA} -> ${path.buildingB} Lv.${path.floorB}',
//                   ),
//                   subtitle: Text('Path type: ${path.pathType}'),
//                   onTap: () {
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => ModifyData(path: path),
//                       ),
//                     );
//                   },
//                   trailing: IconButton(
//                     onPressed: () {
//                       getIt<PathRepository>().deletePath(path.id);
//                       setState(() {});
//                     },
//                     icon: Icon(Icons.delete),
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
