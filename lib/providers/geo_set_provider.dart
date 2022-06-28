import 'package:cemindmap_ui/main.data.dart';
import 'package:flutter_data/flutter_data.dart';

final geoSetProvider = Provider<Set<String>>((ref) {
  var projects = ref.projects.watchAll();

  var geoSet = <String>{};

  if (projects.hasModel) {
    for (var p in projects.model!) {
      geoSet.add(p.geo!);
    }
  }

  return geoSet;
});
