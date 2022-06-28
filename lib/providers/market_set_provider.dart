import 'package:cemindmap_ui/main.data.dart';
import 'package:flutter_data/flutter_data.dart';

final marketSetProvider = Provider<Set<String>>((ref) {
  var projects = ref.projects.watchAll();

  var marketSet = <String>{};

  if (projects.hasModel) {
    for (var p in projects.model!) {
      marketSet.add(p.market!);
    }
  }

  return marketSet;
});
