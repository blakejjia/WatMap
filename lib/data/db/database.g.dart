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
    requiredDuringInsert: true,
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
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> floorIds =
      GeneratedColumn<String>(
        'floor_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>($BuildingsTable.$converterfloorIds);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String> pathIds =
      GeneratedColumn<String>(
        'path_ids',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<int>>($BuildingsTable.$converterpathIds);
  static const VerificationMeta _mainFloorIdMeta = const VerificationMeta(
    'mainFloorId',
  );
  @override
  late final GeneratedColumn<int> mainFloorId = GeneratedColumn<int>(
    'main_floor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    floorIds,
    pathIds,
    mainFloorId,
  ];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('main_floor_id')) {
      context.handle(
        _mainFloorIdMeta,
        mainFloorId.isAcceptableOrUnknown(
          data['main_floor_id']!,
          _mainFloorIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_mainFloorIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
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
      floorIds: $BuildingsTable.$converterfloorIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}floor_ids'],
        )!,
      ),
      pathIds: $BuildingsTable.$converterpathIds.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}path_ids'],
        )!,
      ),
      mainFloorId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}main_floor_id'],
          )!,
    );
  }

  @override
  $BuildingsTable createAlias(String alias) {
    return $BuildingsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<int>, String> $converterfloorIds =
      const IntListConverter();
  static TypeConverter<List<int>, String> $converterpathIds =
      const IntListConverter();
}

class Building extends DataClass implements Insertable<Building> {
  /// Unique id of the Building
  final int id;

  /// Name of the building
  final String name;

  /// Floors of a building
  final List<int> floorIds;

  /// Stairs in a building
  final List<int> pathIds;

  /// Main floor of this building
  final int mainFloorId;
  const Building({
    required this.id,
    required this.name,
    required this.floorIds,
    required this.pathIds,
    required this.mainFloorId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['floor_ids'] = Variable<String>(
        $BuildingsTable.$converterfloorIds.toSql(floorIds),
      );
    }
    {
      map['path_ids'] = Variable<String>(
        $BuildingsTable.$converterpathIds.toSql(pathIds),
      );
    }
    map['main_floor_id'] = Variable<int>(mainFloorId);
    return map;
  }

  BuildingsCompanion toCompanion(bool nullToAbsent) {
    return BuildingsCompanion(
      id: Value(id),
      name: Value(name),
      floorIds: Value(floorIds),
      pathIds: Value(pathIds),
      mainFloorId: Value(mainFloorId),
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
      floorIds: serializer.fromJson<List<int>>(json['floorIds']),
      pathIds: serializer.fromJson<List<int>>(json['pathIds']),
      mainFloorId: serializer.fromJson<int>(json['mainFloorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'floorIds': serializer.toJson<List<int>>(floorIds),
      'pathIds': serializer.toJson<List<int>>(pathIds),
      'mainFloorId': serializer.toJson<int>(mainFloorId),
    };
  }

  Building copyWith({
    int? id,
    String? name,
    List<int>? floorIds,
    List<int>? pathIds,
    int? mainFloorId,
  }) => Building(
    id: id ?? this.id,
    name: name ?? this.name,
    floorIds: floorIds ?? this.floorIds,
    pathIds: pathIds ?? this.pathIds,
    mainFloorId: mainFloorId ?? this.mainFloorId,
  );
  Building copyWithCompanion(BuildingsCompanion data) {
    return Building(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      floorIds: data.floorIds.present ? data.floorIds.value : this.floorIds,
      pathIds: data.pathIds.present ? data.pathIds.value : this.pathIds,
      mainFloorId:
          data.mainFloorId.present ? data.mainFloorId.value : this.mainFloorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Building(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floorIds: $floorIds, ')
          ..write('pathIds: $pathIds, ')
          ..write('mainFloorId: $mainFloorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, floorIds, pathIds, mainFloorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Building &&
          other.id == this.id &&
          other.name == this.name &&
          other.floorIds == this.floorIds &&
          other.pathIds == this.pathIds &&
          other.mainFloorId == this.mainFloorId);
}

class BuildingsCompanion extends UpdateCompanion<Building> {
  final Value<int> id;
  final Value<String> name;
  final Value<List<int>> floorIds;
  final Value<List<int>> pathIds;
  final Value<int> mainFloorId;
  final Value<int> rowid;
  const BuildingsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.floorIds = const Value.absent(),
    this.pathIds = const Value.absent(),
    this.mainFloorId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BuildingsCompanion.insert({
    required int id,
    required String name,
    required List<int> floorIds,
    required List<int> pathIds,
    required int mainFloorId,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       floorIds = Value(floorIds),
       pathIds = Value(pathIds),
       mainFloorId = Value(mainFloorId);
  static Insertable<Building> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? floorIds,
    Expression<String>? pathIds,
    Expression<int>? mainFloorId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (floorIds != null) 'floor_ids': floorIds,
      if (pathIds != null) 'path_ids': pathIds,
      if (mainFloorId != null) 'main_floor_id': mainFloorId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BuildingsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<List<int>>? floorIds,
    Value<List<int>>? pathIds,
    Value<int>? mainFloorId,
    Value<int>? rowid,
  }) {
    return BuildingsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      floorIds: floorIds ?? this.floorIds,
      pathIds: pathIds ?? this.pathIds,
      mainFloorId: mainFloorId ?? this.mainFloorId,
      rowid: rowid ?? this.rowid,
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
    if (floorIds.present) {
      map['floor_ids'] = Variable<String>(
        $BuildingsTable.$converterfloorIds.toSql(floorIds.value),
      );
    }
    if (pathIds.present) {
      map['path_ids'] = Variable<String>(
        $BuildingsTable.$converterpathIds.toSql(pathIds.value),
      );
    }
    if (mainFloorId.present) {
      map['main_floor_id'] = Variable<int>(mainFloorId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BuildingsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('floorIds: $floorIds, ')
          ..write('pathIds: $pathIds, ')
          ..write('mainFloorId: $mainFloorId, ')
          ..write('rowid: $rowid')
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
    requiredDuringInsert: true,
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
  static const VerificationMeta _xMeta = const VerificationMeta('x');
  @override
  late final GeneratedColumn<int> x = GeneratedColumn<int>(
    'x',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yMeta = const VerificationMeta('y');
  @override
  late final GeneratedColumn<int> y = GeneratedColumn<int>(
    'y',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
  static const VerificationMeta _isBuildingMeta = const VerificationMeta(
    'isBuilding',
  );
  @override
  late final GeneratedColumn<bool> isBuilding = GeneratedColumn<bool>(
    'is_building',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_building" IN (0, 1))',
    ),
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
  List<GeneratedColumn> get $columns => [
    id,
    name,
    x,
    y,
    floor,
    isBuilding,
    buildingId,
  ];
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
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('x')) {
      context.handle(_xMeta, x.isAcceptableOrUnknown(data['x']!, _xMeta));
    } else if (isInserting) {
      context.missing(_xMeta);
    }
    if (data.containsKey('y')) {
      context.handle(_yMeta, y.isAcceptableOrUnknown(data['y']!, _yMeta));
    } else if (isInserting) {
      context.missing(_yMeta);
    }
    if (data.containsKey('floor')) {
      context.handle(
        _floorMeta,
        floor.isAcceptableOrUnknown(data['floor']!, _floorMeta),
      );
    }
    if (data.containsKey('is_building')) {
      context.handle(
        _isBuildingMeta,
        isBuilding.isAcceptableOrUnknown(data['is_building']!, _isBuildingMeta),
      );
    } else if (isInserting) {
      context.missing(_isBuildingMeta);
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
  Set<GeneratedColumn> get $primaryKey => {name};
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
      x:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}x'],
          )!,
      y:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}y'],
          )!,
      floor:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}floor'],
          )!,
      isBuilding:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_building'],
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
  final int x;
  final int y;

  /// Floor of the location
  final int floor;

  /// If a location has building = false means it's not a building
  final bool isBuilding;
  final int? buildingId;
  const Location({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
    required this.floor,
    required this.isBuilding,
    this.buildingId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['x'] = Variable<int>(x);
    map['y'] = Variable<int>(y);
    map['floor'] = Variable<int>(floor);
    map['is_building'] = Variable<bool>(isBuilding);
    if (!nullToAbsent || buildingId != null) {
      map['building_id'] = Variable<int>(buildingId);
    }
    return map;
  }

  LocationsCompanion toCompanion(bool nullToAbsent) {
    return LocationsCompanion(
      id: Value(id),
      name: Value(name),
      x: Value(x),
      y: Value(y),
      floor: Value(floor),
      isBuilding: Value(isBuilding),
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
      x: serializer.fromJson<int>(json['x']),
      y: serializer.fromJson<int>(json['y']),
      floor: serializer.fromJson<int>(json['floor']),
      isBuilding: serializer.fromJson<bool>(json['isBuilding']),
      buildingId: serializer.fromJson<int?>(json['buildingId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'x': serializer.toJson<int>(x),
      'y': serializer.toJson<int>(y),
      'floor': serializer.toJson<int>(floor),
      'isBuilding': serializer.toJson<bool>(isBuilding),
      'buildingId': serializer.toJson<int?>(buildingId),
    };
  }

  Location copyWith({
    int? id,
    String? name,
    int? x,
    int? y,
    int? floor,
    bool? isBuilding,
    Value<int?> buildingId = const Value.absent(),
  }) => Location(
    id: id ?? this.id,
    name: name ?? this.name,
    x: x ?? this.x,
    y: y ?? this.y,
    floor: floor ?? this.floor,
    isBuilding: isBuilding ?? this.isBuilding,
    buildingId: buildingId.present ? buildingId.value : this.buildingId,
  );
  Location copyWithCompanion(LocationsCompanion data) {
    return Location(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      x: data.x.present ? data.x.value : this.x,
      y: data.y.present ? data.y.value : this.y,
      floor: data.floor.present ? data.floor.value : this.floor,
      isBuilding:
          data.isBuilding.present ? data.isBuilding.value : this.isBuilding,
      buildingId:
          data.buildingId.present ? data.buildingId.value : this.buildingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Location(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('floor: $floor, ')
          ..write('isBuilding: $isBuilding, ')
          ..write('buildingId: $buildingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, x, y, floor, isBuilding, buildingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Location &&
          other.id == this.id &&
          other.name == this.name &&
          other.x == this.x &&
          other.y == this.y &&
          other.floor == this.floor &&
          other.isBuilding == this.isBuilding &&
          other.buildingId == this.buildingId);
}

class LocationsCompanion extends UpdateCompanion<Location> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> x;
  final Value<int> y;
  final Value<int> floor;
  final Value<bool> isBuilding;
  final Value<int?> buildingId;
  final Value<int> rowid;
  const LocationsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.x = const Value.absent(),
    this.y = const Value.absent(),
    this.floor = const Value.absent(),
    this.isBuilding = const Value.absent(),
    this.buildingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocationsCompanion.insert({
    required int id,
    required String name,
    required int x,
    required int y,
    this.floor = const Value.absent(),
    required bool isBuilding,
    this.buildingId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       x = Value(x),
       y = Value(y),
       isBuilding = Value(isBuilding);
  static Insertable<Location> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? x,
    Expression<int>? y,
    Expression<int>? floor,
    Expression<bool>? isBuilding,
    Expression<int>? buildingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (x != null) 'x': x,
      if (y != null) 'y': y,
      if (floor != null) 'floor': floor,
      if (isBuilding != null) 'is_building': isBuilding,
      if (buildingId != null) 'building_id': buildingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocationsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<int>? x,
    Value<int>? y,
    Value<int>? floor,
    Value<bool>? isBuilding,
    Value<int?>? buildingId,
    Value<int>? rowid,
  }) {
    return LocationsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      x: x ?? this.x,
      y: y ?? this.y,
      floor: floor ?? this.floor,
      isBuilding: isBuilding ?? this.isBuilding,
      buildingId: buildingId ?? this.buildingId,
      rowid: rowid ?? this.rowid,
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
    if (x.present) {
      map['x'] = Variable<int>(x.value);
    }
    if (y.present) {
      map['y'] = Variable<int>(y.value);
    }
    if (floor.present) {
      map['floor'] = Variable<int>(floor.value);
    }
    if (isBuilding.present) {
      map['is_building'] = Variable<bool>(isBuilding.value);
    }
    if (buildingId.present) {
      map['building_id'] = Variable<int>(buildingId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocationsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('x: $x, ')
          ..write('y: $y, ')
          ..write('floor: $floor, ')
          ..write('isBuilding: $isBuilding, ')
          ..write('buildingId: $buildingId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PathsTable extends Paths with TableInfo<$PathsTable, Path> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PathsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    $customConstraints: 'REFERENCES locations(id)',
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
    $customConstraints: 'REFERENCES locations(id)',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pointAId,
    pointBId,
    pathType,
    buildingId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'paths';
  @override
  VerificationContext validateIntegrity(
    Insertable<Path> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {pointAId, pointBId};
  @override
  Path map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Path(
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
    );
  }

  @override
  $PathsTable createAlias(String alias) {
    return $PathsTable(attachedDatabase, alias);
  }
}

class Path extends DataClass implements Insertable<Path> {
  /// Unique id of the Path
  final int id;

  /// Starting and ending points of the path
  final int pointAId;
  final int pointBId;

  /// Type of the path
  final int pathType;
  final int? buildingId;
  const Path({
    required this.id,
    required this.pointAId,
    required this.pointBId,
    required this.pathType,
    this.buildingId,
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
    return map;
  }

  PathsCompanion toCompanion(bool nullToAbsent) {
    return PathsCompanion(
      id: Value(id),
      pointAId: Value(pointAId),
      pointBId: Value(pointBId),
      pathType: Value(pathType),
      buildingId:
          buildingId == null && nullToAbsent
              ? const Value.absent()
              : Value(buildingId),
    );
  }

  factory Path.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Path(
      id: serializer.fromJson<int>(json['id']),
      pointAId: serializer.fromJson<int>(json['pointAId']),
      pointBId: serializer.fromJson<int>(json['pointBId']),
      pathType: serializer.fromJson<int>(json['pathType']),
      buildingId: serializer.fromJson<int?>(json['buildingId']),
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
    };
  }

  Path copyWith({
    int? id,
    int? pointAId,
    int? pointBId,
    int? pathType,
    Value<int?> buildingId = const Value.absent(),
  }) => Path(
    id: id ?? this.id,
    pointAId: pointAId ?? this.pointAId,
    pointBId: pointBId ?? this.pointBId,
    pathType: pathType ?? this.pathType,
    buildingId: buildingId.present ? buildingId.value : this.buildingId,
  );
  Path copyWithCompanion(PathsCompanion data) {
    return Path(
      id: data.id.present ? data.id.value : this.id,
      pointAId: data.pointAId.present ? data.pointAId.value : this.pointAId,
      pointBId: data.pointBId.present ? data.pointBId.value : this.pointBId,
      pathType: data.pathType.present ? data.pathType.value : this.pathType,
      buildingId:
          data.buildingId.present ? data.buildingId.value : this.buildingId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Path(')
          ..write('id: $id, ')
          ..write('pointAId: $pointAId, ')
          ..write('pointBId: $pointBId, ')
          ..write('pathType: $pathType, ')
          ..write('buildingId: $buildingId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pointAId, pointBId, pathType, buildingId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Path &&
          other.id == this.id &&
          other.pointAId == this.pointAId &&
          other.pointBId == this.pointBId &&
          other.pathType == this.pathType &&
          other.buildingId == this.buildingId);
}

class PathsCompanion extends UpdateCompanion<Path> {
  final Value<int> id;
  final Value<int> pointAId;
  final Value<int> pointBId;
  final Value<int> pathType;
  final Value<int?> buildingId;
  final Value<int> rowid;
  const PathsCompanion({
    this.id = const Value.absent(),
    this.pointAId = const Value.absent(),
    this.pointBId = const Value.absent(),
    this.pathType = const Value.absent(),
    this.buildingId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PathsCompanion.insert({
    required int id,
    required int pointAId,
    required int pointBId,
    required int pathType,
    this.buildingId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pointAId = Value(pointAId),
       pointBId = Value(pointBId),
       pathType = Value(pathType);
  static Insertable<Path> custom({
    Expression<int>? id,
    Expression<int>? pointAId,
    Expression<int>? pointBId,
    Expression<int>? pathType,
    Expression<int>? buildingId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pointAId != null) 'point_a_id': pointAId,
      if (pointBId != null) 'point_b_id': pointBId,
      if (pathType != null) 'path_type': pathType,
      if (buildingId != null) 'building_id': buildingId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PathsCompanion copyWith({
    Value<int>? id,
    Value<int>? pointAId,
    Value<int>? pointBId,
    Value<int>? pathType,
    Value<int?>? buildingId,
    Value<int>? rowid,
  }) {
    return PathsCompanion(
      id: id ?? this.id,
      pointAId: pointAId ?? this.pointAId,
      pointBId: pointBId ?? this.pointBId,
      pathType: pathType ?? this.pathType,
      buildingId: buildingId ?? this.buildingId,
      rowid: rowid ?? this.rowid,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PathsCompanion(')
          ..write('id: $id, ')
          ..write('pointAId: $pointAId, ')
          ..write('pointBId: $pointBId, ')
          ..write('pathType: $pathType, ')
          ..write('buildingId: $buildingId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $BuildingsTable buildings = $BuildingsTable(this);
  late final $LocationsTable locations = $LocationsTable(this);
  late final $PathsTable paths = $PathsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    buildings,
    locations,
    paths,
  ];
}

typedef $$BuildingsTableCreateCompanionBuilder =
    BuildingsCompanion Function({
      required int id,
      required String name,
      required List<int> floorIds,
      required List<int> pathIds,
      required int mainFloorId,
      Value<int> rowid,
    });
typedef $$BuildingsTableUpdateCompanionBuilder =
    BuildingsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<List<int>> floorIds,
      Value<List<int>> pathIds,
      Value<int> mainFloorId,
      Value<int> rowid,
    });

class $$BuildingsTableFilterComposer
    extends Composer<_$Database, $BuildingsTable> {
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

  ColumnWithTypeConverterFilters<List<int>, List<int>, String> get floorIds =>
      $composableBuilder(
        column: $table.floorIds,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<List<int>, List<int>, String> get pathIds =>
      $composableBuilder(
        column: $table.pathIds,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get mainFloorId => $composableBuilder(
    column: $table.mainFloorId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BuildingsTableOrderingComposer
    extends Composer<_$Database, $BuildingsTable> {
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

  ColumnOrderings<String> get floorIds => $composableBuilder(
    column: $table.floorIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pathIds => $composableBuilder(
    column: $table.pathIds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mainFloorId => $composableBuilder(
    column: $table.mainFloorId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BuildingsTableAnnotationComposer
    extends Composer<_$Database, $BuildingsTable> {
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

  GeneratedColumnWithTypeConverter<List<int>, String> get floorIds =>
      $composableBuilder(column: $table.floorIds, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String> get pathIds =>
      $composableBuilder(column: $table.pathIds, builder: (column) => column);

  GeneratedColumn<int> get mainFloorId => $composableBuilder(
    column: $table.mainFloorId,
    builder: (column) => column,
  );
}

class $$BuildingsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $BuildingsTable,
          Building,
          $$BuildingsTableFilterComposer,
          $$BuildingsTableOrderingComposer,
          $$BuildingsTableAnnotationComposer,
          $$BuildingsTableCreateCompanionBuilder,
          $$BuildingsTableUpdateCompanionBuilder,
          (Building, BaseReferences<_$Database, $BuildingsTable, Building>),
          Building,
          PrefetchHooks Function()
        > {
  $$BuildingsTableTableManager(_$Database db, $BuildingsTable table)
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
                Value<List<int>> floorIds = const Value.absent(),
                Value<List<int>> pathIds = const Value.absent(),
                Value<int> mainFloorId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BuildingsCompanion(
                id: id,
                name: name,
                floorIds: floorIds,
                pathIds: pathIds,
                mainFloorId: mainFloorId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String name,
                required List<int> floorIds,
                required List<int> pathIds,
                required int mainFloorId,
                Value<int> rowid = const Value.absent(),
              }) => BuildingsCompanion.insert(
                id: id,
                name: name,
                floorIds: floorIds,
                pathIds: pathIds,
                mainFloorId: mainFloorId,
                rowid: rowid,
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
      _$Database,
      $BuildingsTable,
      Building,
      $$BuildingsTableFilterComposer,
      $$BuildingsTableOrderingComposer,
      $$BuildingsTableAnnotationComposer,
      $$BuildingsTableCreateCompanionBuilder,
      $$BuildingsTableUpdateCompanionBuilder,
      (Building, BaseReferences<_$Database, $BuildingsTable, Building>),
      Building,
      PrefetchHooks Function()
    >;
typedef $$LocationsTableCreateCompanionBuilder =
    LocationsCompanion Function({
      required int id,
      required String name,
      required int x,
      required int y,
      Value<int> floor,
      required bool isBuilding,
      Value<int?> buildingId,
      Value<int> rowid,
    });
typedef $$LocationsTableUpdateCompanionBuilder =
    LocationsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<int> x,
      Value<int> y,
      Value<int> floor,
      Value<bool> isBuilding,
      Value<int?> buildingId,
      Value<int> rowid,
    });

class $$LocationsTableFilterComposer
    extends Composer<_$Database, $LocationsTable> {
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

  ColumnFilters<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBuilding => $composableBuilder(
    column: $table.isBuilding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LocationsTableOrderingComposer
    extends Composer<_$Database, $LocationsTable> {
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

  ColumnOrderings<int> get x => $composableBuilder(
    column: $table.x,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get y => $composableBuilder(
    column: $table.y,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get floor => $composableBuilder(
    column: $table.floor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBuilding => $composableBuilder(
    column: $table.isBuilding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocationsTableAnnotationComposer
    extends Composer<_$Database, $LocationsTable> {
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

  GeneratedColumn<int> get x =>
      $composableBuilder(column: $table.x, builder: (column) => column);

  GeneratedColumn<int> get y =>
      $composableBuilder(column: $table.y, builder: (column) => column);

  GeneratedColumn<int> get floor =>
      $composableBuilder(column: $table.floor, builder: (column) => column);

  GeneratedColumn<bool> get isBuilding => $composableBuilder(
    column: $table.isBuilding,
    builder: (column) => column,
  );

  GeneratedColumn<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => column,
  );
}

class $$LocationsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $LocationsTable,
          Location,
          $$LocationsTableFilterComposer,
          $$LocationsTableOrderingComposer,
          $$LocationsTableAnnotationComposer,
          $$LocationsTableCreateCompanionBuilder,
          $$LocationsTableUpdateCompanionBuilder,
          (Location, BaseReferences<_$Database, $LocationsTable, Location>),
          Location,
          PrefetchHooks Function()
        > {
  $$LocationsTableTableManager(_$Database db, $LocationsTable table)
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
                Value<int> x = const Value.absent(),
                Value<int> y = const Value.absent(),
                Value<int> floor = const Value.absent(),
                Value<bool> isBuilding = const Value.absent(),
                Value<int?> buildingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion(
                id: id,
                name: name,
                x: x,
                y: y,
                floor: floor,
                isBuilding: isBuilding,
                buildingId: buildingId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String name,
                required int x,
                required int y,
                Value<int> floor = const Value.absent(),
                required bool isBuilding,
                Value<int?> buildingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocationsCompanion.insert(
                id: id,
                name: name,
                x: x,
                y: y,
                floor: floor,
                isBuilding: isBuilding,
                buildingId: buildingId,
                rowid: rowid,
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
      _$Database,
      $LocationsTable,
      Location,
      $$LocationsTableFilterComposer,
      $$LocationsTableOrderingComposer,
      $$LocationsTableAnnotationComposer,
      $$LocationsTableCreateCompanionBuilder,
      $$LocationsTableUpdateCompanionBuilder,
      (Location, BaseReferences<_$Database, $LocationsTable, Location>),
      Location,
      PrefetchHooks Function()
    >;
typedef $$PathsTableCreateCompanionBuilder =
    PathsCompanion Function({
      required int id,
      required int pointAId,
      required int pointBId,
      required int pathType,
      Value<int?> buildingId,
      Value<int> rowid,
    });
typedef $$PathsTableUpdateCompanionBuilder =
    PathsCompanion Function({
      Value<int> id,
      Value<int> pointAId,
      Value<int> pointBId,
      Value<int> pathType,
      Value<int?> buildingId,
      Value<int> rowid,
    });

final class $$PathsTableReferences
    extends BaseReferences<_$Database, $PathsTable, Path> {
  $$PathsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocationsTable _pointAIdTable(_$Database db) => db.locations
      .createAlias($_aliasNameGenerator(db.paths.pointAId, db.locations.id));

  $$LocationsTableProcessedTableManager get pointAId {
    final $_column = $_itemColumn<int>('point_a_id')!;

    final manager = $$LocationsTableTableManager(
      $_db,
      $_db.locations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointAIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocationsTable _pointBIdTable(_$Database db) => db.locations
      .createAlias($_aliasNameGenerator(db.paths.pointBId, db.locations.id));

  $$LocationsTableProcessedTableManager get pointBId {
    final $_column = $_itemColumn<int>('point_b_id')!;

    final manager = $$LocationsTableTableManager(
      $_db,
      $_db.locations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointBIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PathsTableFilterComposer extends Composer<_$Database, $PathsTable> {
  $$PathsTableFilterComposer({
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

  ColumnFilters<int> get pathType => $composableBuilder(
    column: $table.pathType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnFilters(column),
  );

  $$LocationsTableFilterComposer get pointAId {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointAId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableFilterComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableFilterComposer get pointBId {
    final $$LocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointBId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableFilterComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PathsTableOrderingComposer extends Composer<_$Database, $PathsTable> {
  $$PathsTableOrderingComposer({
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

  ColumnOrderings<int> get pathType => $composableBuilder(
    column: $table.pathType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocationsTableOrderingComposer get pointAId {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointAId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableOrderingComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableOrderingComposer get pointBId {
    final $$LocationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointBId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableOrderingComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PathsTableAnnotationComposer extends Composer<_$Database, $PathsTable> {
  $$PathsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pathType =>
      $composableBuilder(column: $table.pathType, builder: (column) => column);

  GeneratedColumn<int> get buildingId => $composableBuilder(
    column: $table.buildingId,
    builder: (column) => column,
  );

  $$LocationsTableAnnotationComposer get pointAId {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointAId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocationsTableAnnotationComposer get pointBId {
    final $$LocationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointBId,
      referencedTable: $db.locations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocationsTableAnnotationComposer(
            $db: $db,
            $table: $db.locations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PathsTableTableManager
    extends
        RootTableManager<
          _$Database,
          $PathsTable,
          Path,
          $$PathsTableFilterComposer,
          $$PathsTableOrderingComposer,
          $$PathsTableAnnotationComposer,
          $$PathsTableCreateCompanionBuilder,
          $$PathsTableUpdateCompanionBuilder,
          (Path, $$PathsTableReferences),
          Path,
          PrefetchHooks Function({bool pointAId, bool pointBId})
        > {
  $$PathsTableTableManager(_$Database db, $PathsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PathsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$PathsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$PathsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> pointAId = const Value.absent(),
                Value<int> pointBId = const Value.absent(),
                Value<int> pathType = const Value.absent(),
                Value<int?> buildingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PathsCompanion(
                id: id,
                pointAId: pointAId,
                pointBId: pointBId,
                pathType: pathType,
                buildingId: buildingId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required int pointAId,
                required int pointBId,
                required int pathType,
                Value<int?> buildingId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PathsCompanion.insert(
                id: id,
                pointAId: pointAId,
                pointBId: pointBId,
                pathType: pathType,
                buildingId: buildingId,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          $$PathsTableReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: ({pointAId = false, pointBId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                T extends TableManagerState<
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic,
                  dynamic
                >
              >(state) {
                if (pointAId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.pointAId,
                            referencedTable: $$PathsTableReferences
                                ._pointAIdTable(db),
                            referencedColumn:
                                $$PathsTableReferences._pointAIdTable(db).id,
                          )
                          as T;
                }
                if (pointBId) {
                  state =
                      state.withJoin(
                            currentTable: table,
                            currentColumn: table.pointBId,
                            referencedTable: $$PathsTableReferences
                                ._pointBIdTable(db),
                            referencedColumn:
                                $$PathsTableReferences._pointBIdTable(db).id,
                          )
                          as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PathsTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $PathsTable,
      Path,
      $$PathsTableFilterComposer,
      $$PathsTableOrderingComposer,
      $$PathsTableAnnotationComposer,
      $$PathsTableCreateCompanionBuilder,
      $$PathsTableUpdateCompanionBuilder,
      (Path, $$PathsTableReferences),
      Path,
      PrefetchHooks Function({bool pointAId, bool pointBId})
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$BuildingsTableTableManager get buildings =>
      $$BuildingsTableTableManager(_db, _db.buildings);
  $$LocationsTableTableManager get locations =>
      $$LocationsTableTableManager(_db, _db.locations);
  $$PathsTableTableManager get paths =>
      $$PathsTableTableManager(_db, _db.paths);
}
