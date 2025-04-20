part of 'algorithms.dart';

List<Segment> buildSegments(MyMap map, MyRoute route) {
  final all = route.getRoute(map);

  try {
    List<Segment> cleanedSeg;
    cleanedSeg = removeAllOpposites(all);
    return cleanedSeg;
  } catch (e) {
    return all;
  }
}

Point? hasAnyCommonSeg(Segment s1, Segment s2) {
  final ab = s1[1] - s1[0];
  final cd = s2[1] - s2[0];
  if (ab.cross(cd).abs() > EPS) return null; // 不共线

  for (final p1 in s1) {
    for (final p2 in s2) {
      if ((p1 - p2).length <= PT_EPS) {
        return p1;
      }
    }
  }
  return null;
}

Segment removeCommonSegment(Segment s1, Segment s2, Point common) {
  final a = s1.where((p) => (p - common).length > PT_EPS);
  final b = s2.where((p) => (p - common).length > PT_EPS);
  return [...a, ...b]; // 恰好剩 2 个端点
}

List<Segment> removeAllOpposites(List<Segment> segments) {
  for (int i = 0; i < segments.length; i++) {
    for (int j = i + 1; j < segments.length; j++) {
      Point? common = hasAnyCommonSeg(segments[i], segments[j]);
      if (common != null) {
        // 合并两个 segment
        final merged = removeCommonSegment(segments[i], segments[j], common);
        if (merged[0].distanceTo(merged[1]) > 0) {
          segments
            ..removeAt(j)
            ..removeAt(i)
            ..insert(i, merged);
        } else {
          segments
            ..removeAt(j)
            ..removeAt(i);
        }
      }
    }
  }

  return segments;
}
