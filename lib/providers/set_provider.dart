import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/models/project.dart';
import 'package:flutter_data/flutter_data.dart';

Provider<Set<String>> setProvider(
    {required String Function(Project) keyFunction}) {
  return Provider<Set<String>>((ref) {
    var projects = ref.projects.watchAll();
    var set = <String>{};

    if (projects.hasModel) {
      for (var p in projects.model!) {
        set.add(keyFunction(p));
      }
    }

    return set;
  });
}

final accountSetProvider = setProvider(keyFunction: (p) => p.accountName!);
final geoSetProvider = setProvider(keyFunction: (p) => p.geo!);
final marketSetProvider = setProvider(keyFunction: (p) => p.market!);
final squadSetProvider = setProvider(keyFunction: (p) => p.geoMarketSquad!);
