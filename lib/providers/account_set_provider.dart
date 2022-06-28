import 'package:cemindmap_ui/main.data.dart';
import 'package:flutter_data/flutter_data.dart';

final accountSetProvider = Provider<Set<String>>((ref) {
  var projects = ref.projects.watchAll();

  var accountSet = <String>{};

  if (projects.hasModel) {
    for (var p in projects.model!) {
      accountSet.add(p.accountName!);
    }
  }

  return accountSet;
});
