import 'package:json_annotation/json_annotation.dart';

part 'path_raw.g.dart';

@JsonSerializable()
class RawPath {
  final String buildingA;
  final int floorA;
  final String buildingB;
  final int floorB;
  final String pathType;
  final List<List<List<int>>>? route;

  RawPath({
    required this.buildingA,
    required this.floorA,
    required this.buildingB,
    required this.floorB,
    required this.pathType,
    this.route,
  });

  factory RawPath.fromJson(Map<String, dynamic> json) =>
      _$RawPathFromJson(json);

  Map<String, dynamic> toJson() => _$RawPathToJson(this);
}