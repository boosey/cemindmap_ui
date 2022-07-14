import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/models/raw_project.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<Set<String>> setProvider({
  required String Function(RawProject) keyFunction,
  required bool Function(String, RawProject) selectionFunction,
  bool includeAllOption = false,
  StateNotifierProvider<FilterSelection, String>? parentSelectionProvider,
}) {
  return Provider<Set<String>>((ref) {
    var projects = ref.rawProjects.watchAll();
    String parentSelection;
    if (parentSelectionProvider != null) {
      parentSelection = ref.watch(parentSelectionProvider);
    } else {
      parentSelection = "";
    }

    var set = <String>{};

    if (projects.hasModel) {
      if (includeAllOption) {
        set.add("All");
      }
      for (var p in projects.model!) {
        var s = keyFunction(p);
        if (selectionFunction(parentSelection, p) || parentSelection.isEmpty) {
          set.add(s);
        }
      }
    }
    return set;
  });
}

class FilterSelection extends StateNotifier<String> {
  FilterSelection({required this.set}) : super(set.isNotEmpty ? set.first : "");

  final Set<String> set;

  selection(String choice) {
    state = choice;
  }
}

final geoSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  final geoSet = ref.watch(geoSetProvider);
  return FilterSelection(
    set: geoSet,
  );
});

final marketSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  final marketSet = ref.watch(marketSetProvider);
  return FilterSelection(
    set: marketSet,
  );
});

final squadSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  final squadSet = ref.watch(squadSetProvider);
  return FilterSelection(
    set: squadSet,
  );
});

final accountSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  final accountSet = ref.watch(accountSetProvider);
  return FilterSelection(
    set: accountSet,
  );
});

final geoSetProvider = setProvider(
  keyFunction: (p) => p.geo!,
  selectionFunction: (p, s) {
    return true;
  },
);

final marketSetProvider = setProvider(
  keyFunction: (p) => p.market!,
  selectionFunction: (parentSelection, project) =>
      project.geo == parentSelection,
  parentSelectionProvider: geoSelectionProvider,
  includeAllOption: true,
);

final squadSetProvider = setProvider(
  keyFunction: (p) => p.geoMarketSquad!,
  selectionFunction: (marketSelection, project) =>
      project.market == marketSelection,
  parentSelectionProvider: marketSelectionProvider,
  includeAllOption: true,
);

final accountSetProvider = setProvider(
  keyFunction: (p) => p.accountName!,
  selectionFunction: (squadSelection, project) =>
      project.geoMarketSquad == squadSelection,
  parentSelectionProvider: squadSelectionProvider,
  includeAllOption: true,
);
