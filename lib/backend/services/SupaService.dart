import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:watmap/backend/model/base/path_raw.dart';

import '../db/database.dart';

class SupaService {
  final SupabaseClient db;

  SupaService(this.db);

  Future<List<Building>> getBuildings() async {
    List<Map<String, dynamic>>? dat = await db.from('buildings').select();
    return dat.map((e) => Building.fromJson(e)).toList();
  }

  Future<List<Location>> getLocations() async {
    List<Map<String, dynamic>>? dat = await db.from('locations').select();
    return dat.map((e) => Location.fromJson(e)).toList();
  }

  Future<List<RawPath>> getPaths() async {
    List<Map<String, dynamic>>? dat = await db.from('paths').select();
    return dat.map((e) => RawPath.fromJson(e)).toList();
  }

  Future<bool> reportPath(RawPath path) async {
    try {
      await db.from('reports').insert(path.toJson());
      return true;
    } catch (e) {
      print('Error reporting path: $e');
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
      print('Error reporting message: $e');
      return false;
    }
  }
}
