import 'package:cemindmap_ui/main.data.dart';
import 'package:flutter_data/flutter_data.dart';

final squadSetProvider = Provider<Set<String>>((ref) {
  var projects = ref.projects.watchAll();

  var squadSet = <String>{};

  if (projects.hasModel) {
    for (var p in projects.model!) {
      squadSet.add(p.geoMarketSquad!);
    }
  }

  return squadSet;
});
