// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $BuildingsTable extends Buildings
    with TableInfo<$BuildingsTable, Building> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BuildingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _floorMeta = const VerificationMeta('floor');
  @override
  late final GeneratedColumn<int> floor = GeneratedColumn<int>(
    'floor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(1),
  );
  static const VerificationMeta _mainFloorMeta = const VerificationMeta(
    'mainFloor',
  );
  @override
  late final GeneratedColumn<int> mainFloor = GeneratedColumn<int>(
    'main_floor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(1),
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, floor, mainFloor, lat, lng];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'buildings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Building> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('floor')) {
      context.handle(
        _floorMeta,
        floor.isAcceptableOrUnknown(data['floor']!, _floorMeta),
      );
    }
    if (data.containsKey('main_floor')) {
      context.handle(
        _mainFloorMeta,
        mainFloor.isAcceptableOrUnknown(data['main_floor']!, _mainFloorMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Building map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Building(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      floor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}floor'],
          )!,
      mainFloor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}main_floor'],
          )!,
      lat:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lat'],
          )!,
      lng:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lng'],
          )!,
    );
  }

  @override
  $BuildingsTable createAlias(String alias) {
    return $BuildingsTable(attachedDatabase, alias);
  }
}

class Building extends DataClass implements Insertable<Building> {
  /// Unique id of the Building
  final int id;

  /// Name of the building
  final String name;

  /// Main floor of this building
  final int floor;

  /// Main floor of this building
  final int mainFloor;

  /// Position of the building
  final double lat;
  final double lng;
  const Building({
    required this.id,
    required this.name,
    required this.floor,
    required this.mainFloor,
    required this.lat,
    required this.lng,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['floor'] = Variable<int>(floor);
    map['main_floor'] = Variable<int>(mainFloor);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    return map;
  }

  BuildingsCompanion toCompanion(bool nullToAbsent) {
    return BuildingsCompanion(
      id: Value(id),
      name: Value(name),
      floor: Value(floor),
      mainFloor: Value(mainFloor),
      lat: Value(lat),
      lng: Value(lng),
    );
  }

  factory Building.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Building(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      floor: serializer.fromJson<int>(json['floor']),
      mainFloor: serializer.fromJson<int>(json['mainFloor']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'floor': serializer.toJson<int>(floor),
      'mainFloor': serializer.toJson<int>(mainFloor),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
    };
  }

  Building copyWith({
    int? id,
    String? name,
    int? floor,
    int? mainFloor,
    double? lat,
    double? lng,
  }) => Building(
    id: id ?? this.id,
    name: name ?? this.name,
    floor: floor ?? this.floor,
    mainFloor: mainFloor ?? this.mainFloor,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
  );
  Building copyWithCompanion(BuildingsCompanion data) {
    return Building(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      floor: data.floor.present ? data.floor.value : this.floor,
      mainFloor: data.mainFloor.present ? data.mainFloor.value : this.mainFloor,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Building(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floor: $floor, ')
          ..write('mainFloor: $mainFloor, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, floor, mainFloor, lat, lng);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Building &&
          other.id == this.id &&
          other.name == this.name &&
          other.floor == this.floor &&
          other.mainFloor == this.mainFloor &&
          other.lat == this.lat &&
          other.lng == this.lng);
}

class BuildingsCompanion extends UpdateCompanion<Building> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> floor;
  final Value<int> mainFloor;
  final Value<double> lat;
  final Value<double> lng;
  const BuildingsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.floor = const Value.absent(),
    this.mainFloor = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
  });
  BuildingsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.floor = const Value.absent(),
    this.mainFloor = const Value.absent(),
    required double lat,
    required double lng,
  }) : name = Value(name),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<Building> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? floor,
    Expression<int>? mainFloor,
    Expression<double>? lat,
    Expression<double>? lng,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (floor != null) 'floor': floor,
      if (mainFloor != null) 'main_floor': mainFloor,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
    });
  }

  BuildingsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? floor,
    Value<int>? mainFloor,
    Value<double>? lat,
    Value<double>? lng,
  }) {
    return BuildingsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      floor: floor ?? this.floor,
      mainFloor: mainFloor ?? this.mainFloor,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (mainFloor.present) {
      map['main_floor'] = Variable<int>(mainFloor.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildingsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floor: $floor, ')
          ..write('mainFloor: $mainFloor, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng')
          ..write(')'))
        .toString();
  }
}

class $LocationsTable extends Locations
    with TableInfo<$LocationsTable, Location> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lngMeta = const VerificationMeta('lng');
  @override
  late final GeneratedColumn<double> lng = GeneratedColumn<double>(
    'lng',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _floorMeta = const VerificationMeta('floor');
  @override
  late final GeneratedColumn<int> floor = GeneratedColumn<int>(
    'floor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: Constant(0),
  );
  static const VerificationMeta _buildingIdMeta = const VerificationMeta(
    'buildingId',
  );
  @override
  late final GeneratedColumn<int> buildingId = GeneratedColumn<int>(
    'building_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, lat, lng, floor, buildingId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Location> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lng')) {
      context.handle(
        _lngMeta,
        lng.isAcceptableOrUnknown(data['lng']!, _lngMeta),
      );
    } else if (isInserting) {
      context.missing(_lngMeta);
    }
    if (data.containsKey('floor')) {
      context.handle(
        _floorMeta,
        floor.isAcceptableOrUnknown(data['floor']!, _floorMeta),
      );
    }
    if (data.containsKey('building_id')) {
      context.handle(
        _buildingIdMeta,
        buildingId.isAcceptableOrUnknown(data['building_id']!, _buildingIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Location map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Location(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      lat:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lat'],
          )!,
      lng:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}lng'],
          )!,
      floor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}floor'],
          )!,
      buildingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}building_id'],
      ),
    );
  }

  @override
  $LocationsTable createAlias(String alias) {
    return $LocationsTable(attachedDatabase, alias);
  }
}

class Location extends DataClass implements Insertable<Location> {
  /// Unique id of the location
  final int id;

  /// Name of the location
  final String name;

  /// Position of the location
  final double lat;
  final double lng;

  /// which floor
  final int floor;

  /// If a location is inside a building, here should have its id.
  final int? buildingId;
  const Location({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.floor,
    this.buildingId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['lat'] = Variable<double>(lat);
    map['lng'] = Variable<double>(lng);
    map['floor'] = Variable<int>(floor);
    if (!nullToAbsent || buildingId != null) {
      map['building_id'] = Variable<int>(buildingId);
    }
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      name: Value(name),
      lat: Value(lat),
      lng: Value(lng),
      floor: Value(floor),
      buildingId:
          buildingId == null && nullToAbsent
              ? const Value.absent()
              : Value(buildingId),
    );
  }

  factory Location.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Location(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lat: serializer.fromJson<double>(json['lat']),
      lng: serializer.fromJson<double>(json['lng']),
      floor: serializer.fromJson<int>(json['floor']),
      buildingId: serializer.fromJson<int?>(json['buildingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lat': serializer.toJson<double>(lat),
      'lng': serializer.toJson<double>(lng),
      'floor': serializer.toJson<int>(floor),
      'buildingId': serializer.toJson<int?>(buildingId),
    };
  }

  Location copyWith({
    int? id,
    String? name,
    double? lat,
    double? lng,
    int? floor,
    Value<int?> buildingId = const Value.absent(),
  }) => Location(
    id: id ?? this.id,
    name: name ?? this.name,
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    floor: floor ?? this.floor,
    buildingId: buildingId.present ? buildingId.value : this.buildingId,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lat: data.lat.present ? data.lat.value : this.lat,
      lng: data.lng.present ? data.lng.value : this.lng,
      floor: data.floor.present ? data.floor.value : this.floor,
      buildingId:
          data.buildingId.present ? data.buildingId.value : this.buildingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('floor: $floor, ')
          ..write('buildingId: $buildingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, lat, lng, floor, buildingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.name == this.name &&
          other.lat == this.lat &&
          other.lng == this.lng &&
          other.floor == this.floor &&
          other.buildingId == this.buildingId);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> lat;
  final Value<double> lng;
  final Value<int> floor;
  final Value<int?> buildingId;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lat = const Value.absent(),
    this.lng = const Value.absent(),
    this.floor = const Value.absent(),
    this.buildingId = const Value.absent(),
  });
  LocationsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double lat,
    required double lng,
    this.floor = const Value.absent(),
    this.buildingId = const Value.absent(),
  }) : name = Value(name),
       lat = Value(lat),
       lng = Value(lng);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? lat,
    Expression<double>? lng,
    Expression<int>? floor,
    Expression<int>? buildingId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lat != null) 'lat': lat,
      if (lng != null) 'lng': lng,
      if (floor != null) 'floor': floor,
      if (buildingId != null) 'building_id': buildingId,
    });
  }

  LocationsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? lat,
    Value<double>? lng,
    Value<int>? floor,
    Value<int?>? buildingId,
  }) {
    return LocationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      floor: floor ?? this.floor,
      buildingId: buildingId ?? this.buildingId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lng.present) {
      map['lng'] = Variable<double>(lng.value);
    }
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (buildingId.present) {
      map['building_id'] = Variable<int>(buildingId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lat: $lat, ')
          ..write('lng: $lng, ')
          ..write('floor: $floor, ')
          ..write('buildingId: $buildingId')
          ..write(')'))
        .toString();
  }
}

class $MyPathsTable extends MyPaths with TableInfo<$MyPathsTable, MyPath> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyPathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _pointAIdMeta = const VerificationMeta(
    'pointAId',
  );
  @override
  late final GeneratedColumn<int> pointAId = GeneratedColumn<int>(
    'point_a_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointBIdMeta = const VerificationMeta(
    'pointBId',
  );
  @override
  late final GeneratedColumn<int> pointBId = GeneratedColumn<int>(
    'point_b_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathTypeMeta = const VerificationMeta(
    'pathType',
  );
  @override
  late final GeneratedColumn<int> pathType = GeneratedColumn<int>(
    'path_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _buildingIdMeta = const VerificationMeta(
    'buildingId',
  );
  @override
  late final GeneratedColumn<int> buildingId = GeneratedColumn<int>(
    'building_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeMeta = const VerificationMeta('route');
  @override
  late final GeneratedColumn<String> route = GeneratedColumn<String>(
    'route',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pointAId,
    pointBId,
    pathType,
    buildingId,
    route,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_paths';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyPath> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('point_a_id')) {
      context.handle(
        _pointAIdMeta,
        pointAId.isAcceptableOrUnknown(data['point_a_id']!, _pointAIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointAIdMeta);
    }
    if (data.containsKey('point_b_id')) {
      context.handle(
        _pointBIdMeta,
        pointBId.isAcceptableOrUnknown(data['point_b_id']!, _pointBIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointBIdMeta);
    }
    if (data.containsKey('path_type')) {
      context.handle(
        _pathTypeMeta,
        pathType.isAcceptableOrUnknown(data['path_type']!, _pathTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_pathTypeMeta);
    }
    if (data.containsKey('building_id')) {
      context.handle(
        _buildingIdMeta,
        buildingId.isAcceptableOrUnknown(data['building_id']!, _buildingIdMeta),
      );
    }
    if (data.containsKey('route')) {
      context.handle(
        _routeMeta,
        route.isAcceptableOrUnknown(data['route']!, _routeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyPath map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyPath(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      pointAId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}point_a_id'],
          )!,
      pointBId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}point_b_id'],
          )!,
      pathType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}path_type'],
          )!,
      buildingId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}building_id'],
      ),
      route: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route'],
      ),
    );
  }

  @override
  $MyPathsTable createAlias(String alias) {
    return $MyPathsTable(attachedDatabase, alias);
  }
}

class MyPath extends DataClass implements Insertable<MyPath> {
  /// Unique id of the Path
  final int id;

  /// Starting and ending points of the path
  final int pointAId;
  final int pointBId;

  /// Type of the path
  final int pathType;
  final int? buildingId;

  /// optional if there is a route
  final String? route;
  const MyPath({
    required this.id,
    required this.pointAId,
    required this.pointBId,
    required this.pathType,
    this.buildingId,
    this.route,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['point_a_id'] = Variable<int>(pointAId);
    map['point_b_id'] = Variable<int>(pointBId);
    map['path_type'] = Variable<int>(pathType);
    if (!nullToAbsent || buildingId != null) {
      map['building_id'] = Variable<int>(buildingId);
    }
    if (!nullToAbsent || route != null) {
      map['route'] = Variable<String>(route);
    }
    return map;
  }

  MyPathsCompanion toCompanion(bool nullToAbsent) {
    return MyPathsCompanion(
      id: Value(id),
      pointAId: Value(pointAId),
      pointBId: Value(pointBId),
      pathType: Value(pathType),
      buildingId:
          buildingId == null && nullToAbsent
              ? const Value.absent()
              : Value(buildingId),
      route:
          route == null && nullToAbsent ? const Value.absent() : Value(route),
    );
  }

  factory MyPath.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyPath(
      id: serializer.fromJson<int>(json['id']),
      pointAId: serializer.fromJson<int>(json['pointAId']),
      pointBId: serializer.fromJson<int>(json['pointBId']),
      pathType: serializer.fromJson<int>(json['pathType']),
      buildingId: serializer.fromJson<int?>(json['buildingId']),
      route: serializer.fromJson<String?>(json['route']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pointAId': serializer.toJson<int>(pointAId),
      'pointBId': serializer.toJson<int>(pointBId),
      'pathType': serializer.toJson<int>(pathType),
      'buildingId': serializer.toJson<int?>(buildingId),
      'route': serializer.toJson<String?>(route),
    };
  }

  MyPath copyWith({
    int? id,
    int? pointAId,
    int? pointBId,
    int? pathType,
    Value<int?> buildingId = const Value.absent(),
    Value<String?> route = const Value.absent(),
  }) => MyPath(
    id: id ?? this.id,
    pointAId: pointAId ?? this.pointAId,
    pointBId: pointBId ?? this.pointBId,
    pathType: pathType ?? this.pathType,
    buildingId: buildingId.present ? buildingId.value : this.buildingId,
    route: route.present ? route.value : this.route,
  );
  MyPath copyWithCompanion(MyPathsCompanion data) {
    return MyPath(
      id: data.id.present ? data.id.value : this.id,
      pointAId: data.pointAId.present ? data.pointAId.value : this.pointAId,
      pointBId: data.pointBId.present ? data.pointBId.value : this.pointBId,
      pathType: data.pathType.present ? data.pathType.value : this.pathType,
      buildingId:
          data.buildingId.present ? data.buildingId.value : this.buildingId,
      route: data.route.present ? data.route.value : this.route,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyPath(')
          ..write('id: $id, ')
          ..write('pointAId: $pointAId, ')
          ..write('pointBId: $pointBId, ')
          ..write('pathType: $pathType, ')
          ..write('buildingId: $buildingId, ')
          ..write('route: $route')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pointAId, pointBId, pathType, buildingId, route);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyPath &&
          other.id == this.id &&
          other.pointAId == this.pointAId &&
          other.pointBId == this.pointBId &&
          other.pathType == this.pathType &&
          other.buildingId == this.buildingId &&
          other.route == this.route);
}

class MyPathsCompanion extends UpdateCompanion<MyPath> {
  final Value<int> id;
  final Value<int> pointAId;
  final Value<int> pointBId;
  final Value<int> pathType;
  final Value<int?> buildingId;
  final Value<String?> route;
  const MyPathsCompanion({
    this.id = const Value.absent(),
    this.pointAId = const Value.absent(),
    this.pointBId = const Value.absent(),
    this.pathType = const Value.absent(),
    this.buildingId = const Value.absent(),
    this.route = const Value.absent(),
  });
  MyPathsCompanion.insert({
    this.id = const Value.absent(),
    required int pointAId,
    required int pointBId,
    required int pathType,
    this.buildingId = const Value.absent(),
    this.route = const Value.absent(),
  }) : pointAId = Value(pointAId),
       pointBId = Value(pointBId),
       pathType = Value(pathType);
  static Insertable<MyPath> custom({
    Expression<int>? id,
    Expression<int>? pointAId,
    Expression<int>? pointBId,
    Expression<int>? pathType,
    Expression<int>? buildingId,
    Expression<String>? route,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pointAId != null) 'point_a_id': pointAId,
      if (pointBId != null) 'point_b_id': pointBId,
      if (pathType != null) 'path_type': pathType,
      if (buildingId != null) 'building_id': buildingId,
      if (route != null) 'route': route,
    });
  }

  MyPathsCompanion copyWith({
    Value<int>? id,
    Value<int>? pointAId,
    Value<int>? pointBId,
    Value<int>? pathType,
    Value<int?>? buildingId,
    Value<String?>? route,
  }) {
    return MyPathsCompanion(
      id: id ?? this.id,
      pointAId: pointAId ?? this.pointAId,
      pointBId: pointBId ?? this.pointBId,
      pathType: pathType ?? this.pathType,
      buildingId: buildingId ?? this.buildingId,
      route: route ?? this.route,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pointAId.present) {
      map['point_a_id'] = Variable<int>(pointAId.value);
    }
    if (pointBId.present) {
      map['point_b_id'] = Variable<int>(pointBId.value);
    }
    if (pathType.present) {
      map['path_type'] = Variable<int>(pathType.value);
    }
    if (buildingId.present) {
      map['building_id'] = Variable<int>(buildingId.value);
    }
    if (route.present) {
      map['route'] = Variable<String>(route.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyPathsCompanion(')
          ..write('id: $id, ')
          ..write('pointAId: $pointAId, ')
          ..write('pointBId: $pointBId, ')
          ..write('pathType: $pathType, ')
          ..write('buildingId: $buildingId, ')
          ..write('route: $route')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BuildingsTable buildings = $BuildingsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $MyPathsTable myPaths = $MyPathsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    buildings,
    locations,
    myPaths,
  ];
}

typedef $$BuildingsTableCreateCompanionBuilder =
    BuildingsCompanion Function({
      Value<int> id,
      required String name,
      Value<int> floor,
      Value<int> mainFloor,
      required double lat,
      required double lng,
    });
typedef $$BuildingsTableUpdateCompanionBuilder =
    BuildingsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> floor,
      Value<int> mainFloor,
      Value<double> lat,
      Value<double> lng,
    });

class $$BuildingsTableFilterComposer
    extends Composer<_$AppDatabase, $BuildingsTable> {
  $$BuildingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mainFloor => $composableBuilder(
    column: $table.mainFloor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuildingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BuildingsTable> {
  $$BuildingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mainFloor => $composableBuilder(
    column: $table.mainFloor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuildingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BuildingsTable> {
  $$BuildingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get floor =>
      $composableBuilder(column: $table.floor, builder: (column) => column);

  GeneratedColumn<int> get mainFloor =>
      $composableBuilder(column: $table.mainFloor, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);
}

class $$BuildingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BuildingsTable,
          Building,
          $$BuildingsTableFilterComposer,
          $$BuildingsTableOrderingComposer,
          $$BuildingsTableAnnotationComposer,
          $$BuildingsTableCreateCompanionBuilder,
          $$BuildingsTableUpdateCompanionBuilder,
          (Building, BaseReferences<_$AppDatabase, $BuildingsTable, Building>),
          Building,
          PrefetchHooks Function()
        > {
  $$BuildingsTableTableManager(_$AppDatabase db, $BuildingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$BuildingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$BuildingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$BuildingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> floor = const Value.absent(),
                Value<int> mainFloor = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
              }) => BuildingsCompanion(
                id: id,
                name: name,
                floor: floor,
                mainFloor: mainFloor,
                lat: lat,
                lng: lng,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<int> floor = const Value.absent(),
                Value<int> mainFloor = const Value.absent(),
                required double lat,
                required double lng,
              }) => BuildingsCompanion.insert(
                id: id,
                name: name,
                floor: floor,
                mainFloor: mainFloor,
                lat: lat,
                lng: lng,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BuildingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BuildingsTable,
      Building,
      $$BuildingsTableFilterComposer,
      $$BuildingsTableOrderingComposer,
      $$BuildingsTableAnnotationComposer,
      $$BuildingsTableCreateCompanionBuilder,
      $$BuildingsTableUpdateCompanionBuilder,
      (Building, BaseReferences<_$AppDatabase, $BuildingsTable, Building>),
      Building,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      Value<int> id,
      required String name,
      required double lat,
      required double lng,
      Value<int> floor,
      Value<int?> buildingId,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> lat,
      Value<double> lng,
      Value<int> floor,
      Value<int?> buildingId,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lng => $composableBuilder(
    column: $table.lng,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocationsTable> {
  $$LocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lng =>
      $composableBuilder(column: $table.lng, builder: (column) => column);

  GeneratedColumn<int> get floor =>
      $composableBuilder(column: $table.floor, builder: (column) => column);

  GeneratedColumn<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => column,
  );
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$AppDatabase db, $LocationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LocationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lng = const Value.absent(),
                Value<int> floor = const Value.absent(),
                Value<int?> buildingId = const Value.absent(),
              }) => LocationsCompanion(
                id: id,
                name: name,
                lat: lat,
                lng: lng,
                floor: floor,
                buildingId: buildingId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double lat,
                required double lng,
                Value<int> floor = const Value.absent(),
                Value<int?> buildingId = const Value.absent(),
              }) => LocationsCompanion.insert(
                id: id,
                name: name,
                lat: lat,
                lng: lng,
                floor: floor,
                buildingId: buildingId,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$AppDatabase, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;
typedef $$MyPathsTableCreateCompanionBuilder =
    MyPathsCompanion Function({
      Value<int> id,
      required int pointAId,
      required int pointBId,
      required int pathType,
      Value<int?> buildingId,
      Value<String?> route,
    });
typedef $$MyPathsTableUpdateCompanionBuilder =
    MyPathsCompanion Function({
      Value<int> id,
      Value<int> pointAId,
      Value<int> pointBId,
      Value<int> pathType,
      Value<int?> buildingId,
      Value<String?> route,
    });

class $$MyPathsTableFilterComposer
    extends Composer<_$AppDatabase, $MyPathsTable> {
  $$MyPathsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointAId => $composableBuilder(
    column: $table.pointAId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointBId => $composableBuilder(
    column: $table.pointBId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pathType => $composableBuilder(
    column: $table.pathType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MyPathsTableOrderingComposer
    extends Composer<_$AppDatabase, $MyPathsTable> {
  $$MyPathsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointAId => $composableBuilder(
    column: $table.pointAId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointBId => $composableBuilder(
    column: $table.pointBId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pathType => $composableBuilder(
    column: $table.pathType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MyPathsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MyPathsTable> {
  $$MyPathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pointAId =>
      $composableBuilder(column: $table.pointAId, builder: (column) => column);

  GeneratedColumn<int> get pointBId =>
      $composableBuilder(column: $table.pointBId, builder: (column) => column);

  GeneratedColumn<int> get pathType =>
      $composableBuilder(column: $table.pathType, builder: (column) => column);

  GeneratedColumn<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get route =>
      $composableBuilder(column: $table.route, builder: (column) => column);
}

class $$MyPathsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MyPathsTable,
          MyPath,
          $$MyPathsTableFilterComposer,
          $$MyPathsTableOrderingComposer,
          $$MyPathsTableAnnotationComposer,
          $$MyPathsTableCreateCompanionBuilder,
          $$MyPathsTableUpdateCompanionBuilder,
          (MyPath, BaseReferences<_$AppDatabase, $MyPathsTable, MyPath>),
          MyPath,
          PrefetchHooks Function()
        > {
  $$MyPathsTableTableManager(_$AppDatabase db, $MyPathsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$MyPathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$MyPathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$MyPathsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pointAId = const Value.absent(),
                Value<int> pointBId = const Value.absent(),
                Value<int> pathType = const Value.absent(),
                Value<int?> buildingId = const Value.absent(),
                Value<String?> route = const Value.absent(),
              }) => MyPathsCompanion(
                id: id,
                pointAId: pointAId,
                pointBId: pointBId,
                pathType: pathType,
                buildingId: buildingId,
                route: route,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int pointAId,
                required int pointBId,
                required int pathType,
                Value<int?> buildingId = const Value.absent(),
                Value<String?> route = const Value.absent(),
              }) => MyPathsCompanion.insert(
                id: id,
                pointAId: pointAId,
                pointBId: pointBId,
                pathType: pathType,
                buildingId: buildingId,
                route: route,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MyPathsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MyPathsTable,
      MyPath,
      $$MyPathsTableFilterComposer,
      $$MyPathsTableOrderingComposer,
      $$MyPathsTableAnnotationComposer,
      $$MyPathsTableCreateCompanionBuilder,
      $$MyPathsTableUpdateCompanionBuilder,
      (MyPath, BaseReferences<_$AppDatabase, $MyPathsTable, MyPath>),
      MyPath,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BuildingsTableTableManager get buildings =>
      $$BuildingsTableTableManager(_db, _db.buildings);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$MyPathsTableTableManager get myPaths =>
      $$MyPathsTableTableManager(_db, _db.myPaths);
}
