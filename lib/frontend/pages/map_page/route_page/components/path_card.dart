part of '../route_page.dart';

Widget _pathCard(MyPath path, MyMap map, int index) {
  return Column(
    children: [
      Text(
        "At ${path.toLocAString(map)}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      Text(
        _parsePath(path),
        style: TextStyle(fontSize: 18, color: Colors.brown),
      ),
      Text(
        "to ${path.toLocBString(map)}",
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      Divider(),
    ],
  );
}

Widget _startCard(MyPath path, MyMap map) {
  return ListTile(
    title: Text(
      "Starts your journey at ${path.toLocAString(map)}",
      style: TextStyle(fontSize: 18),
    ),
  );
}

Widget _endCard(MyPath path, MyMap map) {
  return ListTile(
    title: Text(
      "And you will arrive ${path.toLocBString(map)} 😊",
      style: TextStyle(fontSize: 18),
    ),
  );
}

Widget _construction() {
  return Text("This page is Still under construction!", style: TextStyle(
    fontSize: 18,
    color: Colors.red,
  ),);
}

String _parsePath(MyPath path) {
  String sPath = "";
  switch (path.pathType) {
    case PATH_OUTSIDE:
      sPath += "You have to go outside 🚶‍➡️";
    case PATH_INSIDE:
      sPath += "Stay inside and you will find a way 🏢";
    case PATH_STAIRS:
      sPath += "take the stairs 🧗";
    case PATH_TUNNEL:
      sPath += "There should be a tunnel 🔮";
    case PATH_BRIDGE:
      sPath += "There should be a bridge 🌉";
    case PATH_BRIEFLY_OUTSIDE:
      sPath += "You have to go briefly outside ☔";
    default:
      sPath += "This path might be wrong 😒";
  }
  return sPath;
}
