import 'dart:convert';
import 'package:vector_math/vector_math.dart';
import 'package:watmap/backend/model/base/my_path.dart';
import '../../../../backend/db/database.dart';
import '../../../../backend/model/mid/my_map.dart';

typedef Point = Vector2;
typedef Segment = List<Point>;

const double EPS = 0.1;
const double PT_EPS = 1;
List<Segment> buildSegments(MyMap map, List<MyPath> paths) {
  final all = <Segment>[];

  for (final p in paths) {
    if (p.route != null && p.route!.isNotEmpty && p.route != 'null') {
      final segments = (jsonDecode(p.route!) as List)
          .map<Segment>((seg) => (seg as List)
          .map<Point>((q) => Point(q[0].toDouble(), q[1].toDouble()))
          .toList())
          .where((seg) => (seg[0] - seg[1]).length > PT_EPS)
          .toList();

      all.addAll(segments);
      continue;
    } else{
      if(p.pathType==PATH_STAIRS) continue;
      final a = map.locations.firstWhere((e) => e.id == p.pointAId);
      final b = map.locations.firstWhere((e) => e.id == p.pointBId);
      all.add([
        Point(a.x.toDouble(), a.y.toDouble()),
        Point(b.x.toDouble(), b.y.toDouble()),
      ]);
    }
  }

  return removeAllOpposites(all);
}

Point? hasAnyCommonSeg(Segment s1, Segment s2) {
  final ab = s1[1] - s1[0];
  final cd = s2[1] - s2[0];
  if (ab.cross(cd).abs() > EPS) return null;      // 不共线

  for (final p1 in s1) {
    for (final p2 in s2) {
      if ((p1 - p2).length <= PT_EPS) {
        return p1;
      };  // 有公共端点
    }
  }
  return null;
}

Segment removeCommonSegment(Segment s1, Segment s2, Point common) {
  final a = s1.where((p) => (p - common).length > PT_EPS);
  final b = s2.where((p) => (p - common).length > PT_EPS);
  return [...a, ...b];   // 恰好剩 2 个端点
}

List<Segment> removeAllOpposites(List<Segment> segments) {
  for (int i = 0; i < segments.length; i++) {
    for (int j = i + 1; j < segments.length; j++) {
      Point? common = hasAnyCommonSeg(segments[i], segments[j]);
      if (common != null) {
        // 合并两个 segment
        final merged = removeCommonSegment(segments[i], segments[j], common);
        segments
          ..removeAt(j)
          ..removeAt(i)
          ..insert(i, merged);
      }
    }
  }

  return segments;
}