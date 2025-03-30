// part of '../report_route_page.dart';

// Widget _uWMap(BuildContext context) {
//   return ElevatedButton(
//     onPressed: () {
//       Navigator.of(
//         context,
//       ).push(MaterialPageRoute(builder: (context) => const TheMap()));
//     },
//     child: Text("View Map"),
//   );
// }

// class TheMap extends StatelessWidget {
//   const TheMap({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InteractiveViewer.builder(
//         transformationController: TransformationController(
//           Matrix4.identity()..translate(-2500.0, -1200.0),
//         ),
//         minScale: 0.1,
//         builder: (BuildContext context, vector_math.Quad viewport) {
//           return Image.asset('assets/campusMap.png', fit: BoxFit.contain);
//         },
//       ),
//     );
//   }
// }
