import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:cemindmap_ui/providers/filtered_nodes_providers.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Provider<Set<String>> setProvider({
  required bool Function(String, NodeData) selectionFunction,
  required Provider<Set<NodeData>> nodeSet,
  StateNotifierProvider<FilterSelection, String>? parentSelectionProvider,
}) {
  return Provider<Set<String>>((ref) {
    final filteredNodes = ref.watch(nodeSet);
    String parentSelection;
    if (parentSelectionProvider != null) {
      parentSelection = ref.watch(parentSelectionProvider);
    } else {
      parentSelection = "All";
    }

    var set = <String>{"All"};

    for (var p in filteredNodes) {
      if (selectionFunction(parentSelection, p) ||
          parentSelection.isEmpty ||
          parentSelection == "All") {
        set.add(p.name);
      }
    }

    return set;
  });
}

class FilterSelection extends StateNotifier<String> {
  FilterSelection() : super("All");

  selection(String choice) {
    state = choice;
  }
}

final StateNotifierProvider<FilterSelection, String> geoSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  return FilterSelection();
});

final StateNotifierProvider<FilterSelection, String> marketSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  return FilterSelection();
});

final StateNotifierProvider<FilterSelection, String> squadSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  return FilterSelection();
});

final StateNotifierProvider<FilterSelection, String> accountSelectionProvider =
    StateNotifierProvider<FilterSelection, String>((ref) {
  return FilterSelection();
});

final geoFilterOptionsProvider = setProvider(
  nodeSet: filteredGeoNodesProvider,
  selectionFunction: (p, s) {
    return true;
  },
);

final marketFilterOptionsProvider = setProvider(
  nodeSet: marketsProvider,
  selectionFunction: (geoSelection, item) {
    final m = item as MarketNode;
    return m.geoNode.name == geoSelection;
  },
  parentSelectionProvider: geoSelectionProvider,
);

final squadFilterOptionsProvider = setProvider(
  nodeSet: squadsProvider,
  selectionFunction: (marketSelection, item) {
    final s = item as SquadNode;
    return s.marketNode.name == marketSelection;
  },
  parentSelectionProvider: marketSelectionProvider,
);

final accountFilterOptionsProvider = setProvider(
  nodeSet: accountsProvider,
  selectionFunction: (squadSelection, node) {
    final a = node as AccountNode;
    return a.squadNode.name == squadSelection;
  },
  parentSelectionProvider: squadSelectionProvider,
);
