import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watmap/backend/model/base/building.dart';
import 'package:watmap/backend/model/base/location.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import 'package:watmap/backend/model/base/path_raw.dart';

import '../db/database.dart';

class SupaService {
  final SupabaseClient db;

  SupaService(this.db);

  Future<List<Building>> getBuildings() async {
    List<Map<String, dynamic>>? dat = await db.from('buildings').select();
    return dat.map((e) => buildingFromJsonWithSnakeCase(e)).toList();
  }

  Future<List<Location>> getLocations() async {
    List<Map<String, dynamic>>? dat = await db.from('locations').select();
    return dat.map((e) => locationFromJsonWithSnakeCase(e)).toList();
  }

  Future<List<MyPath>> getPaths() async {
    List<Map<String, dynamic>>? dat = await db.from('paths').select();
    return dat.map((e) => pathFromJsonWithSnakeCase(e)).toList();
  }

  Future<bool> reportPath(RawPath path) async {
    try {
      await db.from('messages').insert({
        'message': path.toJson(),
        'contact': 'path report',
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> reportMessage(String message, String contact) async {
    try {
      await db.from('messages').insert({
        'message': message,
        'contact': contact,
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
