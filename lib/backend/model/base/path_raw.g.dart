// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'path_raw.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawPath _$RawPathFromJson(Map<String, dynamic> json) => RawPath(
  buildingA: json['buildingA'] as String,
  floorA: (json['floorA'] as num).toInt(),
  buildingB: json['buildingB'] as String,
  floorB: (json['floorB'] as num).toInt(),
  pathType: json['pathType'] as String,
  route:
      (json['route'] as List<dynamic>?)
          ?.map(
            (e) =>
                (e as List<dynamic>)
                    .map(
                      (e) =>
                          (e as List<dynamic>)
                              .map((e) => (e as num).toInt())
                              .toList(),
                    )
                    .toList(),
          )
          .toList(),
);

Map<String, dynamic> _$RawPathToJson(RawPath instance) => <String, dynamic>{
  'buildingA': instance.buildingA,
  'floorA': instance.floorA,
  'buildingB': instance.buildingB,
  'floorB': instance.floorB,
  'pathType': instance.pathType,
  'route': instance.route,
};
