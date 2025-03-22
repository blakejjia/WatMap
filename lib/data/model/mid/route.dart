import 'package:watmap/data/db/database.dart';

class Route{
  final List<Path> paths;
  final Location start;
  final Location end;

  Route(this.paths, this.start, this.end);
}