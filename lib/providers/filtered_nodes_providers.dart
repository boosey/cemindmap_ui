import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:cemindmap_ui/providers/filter_provider.dart';
import 'package:flutter_data/flutter_data.dart';

final searchTermProvider = Provider<String>(
  (ref) => '',
);

bool passesFilter<T extends NodeData>(
  T node,
  String searchTerms,
  bool Function(T) filterFunction,
) {
  return filterFunction(node) && node.search(searchTerms);
}

bool isAllOrMatches(String s, String n) {
  return s == allString ? true : s == n;
}

final filteredGeoNodesProvider = Provider<Set<GeoNode>>((ref) {
  final geos = ref.watch(allGeosProvider);
  final filter = ref.watch(filterProvider);

  final nodes = geos
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (GeoNode n) => isAllOrMatches(filter.geoSelection, n.name),
        ),
      )
      .toSet();

  return nodes.isNotEmpty ? nodes.toSet() : {};
});

final filteredMarketNodesProvider = Provider<Set<MarketNode>>((ref) {
  final markets = ref.watch(allMarketsProvider);
  final filter = ref.watch(filterProvider);

  final nodes = markets.where(
    (node) => passesFilter(
      node,
      filter.searchTerms,
      (MarketNode n) =>
          isAllOrMatches(filter.marketSelection, n.name) &&
          isAllOrMatches(filter.geoSelection, n.geoNode.name),
    ),
  );

  return nodes.isNotEmpty ? nodes.toSet() : {};
});

final filteredSquadNodesProvider = Provider<Set<SquadNode>>((ref) {
  final squads = ref.watch(allSquadsProvider);
  final filter = ref.watch(filterProvider);

  final nodes = squads
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (SquadNode n) =>
              isAllOrMatches(filter.squadSelection, n.name) &&
              isAllOrMatches(filter.marketSelection, n.marketNode.name) &&
              isAllOrMatches(filter.geoSelection, n.marketNode.geoNode.name),
        ),
      )
      .toSet();

  return nodes.isNotEmpty ? nodes.toSet() : {};
});

final filteredAccountNodesProvider = Provider<Set<AccountNode>>((ref) {
  final accounts = ref.watch(allAccountsProvider);
  final filter = ref.watch(filterProvider);

  final nodes = accounts
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (AccountNode n) =>
              isAllOrMatches(filter.accountSelection, n.name) &&
              isAllOrMatches(filter.squadSelection, n.squadNode.name) &&
              isAllOrMatches(
                  filter.marketSelection, n.squadNode.marketNode.name) &&
              isAllOrMatches(
                  filter.geoSelection, n.squadNode.marketNode.geoNode.name),
        ),
      )
      .toSet();

  return nodes.isNotEmpty ? nodes.toSet() : {};
});

final filteredProjectNodesProvider = Provider<Set<ProjectNode>>((ref) {
  final projects = ref.watch(allProjectsProvider);
  final filter = ref.watch(filterProvider);

  final nodes = projects
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (ProjectNode n) =>
              isAllOrMatches(filter.accountSelection, n.account.name) &&
              isAllOrMatches(filter.squadSelection, n.account.squadNode.name) &&
              isAllOrMatches(filter.marketSelection,
                  n.account.squadNode.marketNode.name) &&
              isAllOrMatches(filter.geoSelection,
                  n.account.squadNode.marketNode.geoNode.name),
        ),
      )
      .toSet();

  return nodes.isNotEmpty ? nodes.toSet() : {};
});
