part of '../route_page.dart';

Widget _pathCard(MyPath path, MyMap map, int index) {
  index = index - 1;
  return Card(
    margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Text(
            "At ${_location(path.pointAId, map)}",
            style: TextStyle(fontSize: 18),
          ),
          Text(_parsePath(path), style: TextStyle(fontSize: 18, color: Colors.brown)),
          Text(
            "to ${_location(path.pointBId, map)}",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    ),
  );
}

Widget _startCard(MyPath path, MyMap map) {
  return ListTile(
    title: Text(
      "Starts your journey at ${_location(path.pointAId, map)}",
      style: TextStyle(fontSize: 18),
    ),
  );
}

Widget _endCard(MyPath path, MyMap map) {
  return ListTile(
    title: Text("And you will arrive ${_location(path.pointBId, map)} 😊"),
  );
}

String _location(int id, MyMap map) {
  Location location = map.locations.firstWhere((location) => location.id == id);
  return "${location.name} Lv.${location.floor}";
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
    case PATH_ELEVATOR:
      sPath += "take the elevator 🛗";
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
