import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:cemindmap_ui/providers/filter_provider.dart';
import 'package:flutter_data/flutter_data.dart';

final searchTermProvider = Provider<String>(
  (ref) => '',
);

final filteredGeoNodesProvider = Provider<Set<GeoNode>>((ref) {
  final geos = ref.watch(geosProvider);
  final filter = ref.watch(filterProvider);
  // final term = ref.watch(searchTermProvider);

  bool Function(GeoNode) getGeoSelectionFunction(String geoSelection) {
    return geoSelection == "All"
        ? (p0) => true
        : (p0) => p0.name == geoSelection;
  }

  bool Function(GeoNode) geoSelectionFunction =
      getGeoSelectionFunction(filter.geoSelection);

  final filtered = geos.where((a) => geoSelectionFunction(a)).toSet();

  // filtered.toList().where((a) => a.search(term)).toSet();

  // final searched = filtered.toList().where((a) => a.search(term)).toSet();

  // return searched;

  return filtered;
});

final filteredMarketNodesProvider = Provider<Set<MarketNode>>((ref) {
  final markets = ref.watch(marketsProvider);
  final filter = ref.watch(filterProvider);
  // final term = ref.watch(searchTermProvider);

  bool Function(MarketNode) getGeoSelectionFunction(String geoSelection) {
    return geoSelection == "All"
        ? (p0) => true
        : (p0) => p0.geoNode.name == geoSelection;
  }

  bool Function(MarketNode) getMarketSelectionFunction(String marketSelection) {
    return marketSelection == "All"
        ? (p0) => true
        : (p0) => p0.name == marketSelection;
  }

  bool Function(MarketNode) marketSelectionFunction =
      getMarketSelectionFunction(filter.marketSelection);
  bool Function(MarketNode) geoSelectionFunction =
      getGeoSelectionFunction(filter.geoSelection);

  final filtered = markets
      .where((a) => marketSelectionFunction(a) && geoSelectionFunction(a))
      .toSet();

  // final searched = filtered.toList().where((a) => a.search(term)).toSet();

  // return searched;

  return filtered;
});

final filteredSquadNodesProvider = Provider<Set<SquadNode>>((ref) {
  final squads = ref.watch(squadsProvider);
  final filter = ref.watch(filterProvider);
  // final term = ref.watch(searchTermProvider);

  bool Function(SquadNode) getGeoSelectionFunction(String geoSelection) {
    return geoSelection == "All"
        ? (p0) => true
        : (p0) => p0.marketNode.geoNode.name == geoSelection;
  }

  bool Function(SquadNode) getMarketSelectionFunction(String marketSelection) {
    return marketSelection == "All"
        ? (p0) => true
        : (p0) => p0.marketNode.name == marketSelection;
  }

  bool Function(SquadNode) getSquadSelectionFunction(
    String squadSelection,
  ) {
    return squadSelection == "All"
        ? (p0) => true
        : (p0) => p0.name == squadSelection;
  }

  bool Function(SquadNode) squadSelectionFunction =
      getSquadSelectionFunction(filter.squadSelection);
  bool Function(SquadNode) marketSelectionFunction =
      getMarketSelectionFunction(filter.marketSelection);
  bool Function(SquadNode) geoSelectionFunction =
      getGeoSelectionFunction(filter.geoSelection);

  final filtered = squads
      .where((a) =>
          squadSelectionFunction(a) &&
          marketSelectionFunction(a) &&
          geoSelectionFunction(a))
      .toSet();

  // final searched = filtered.toList().where((a) => a.search(term)).toSet();

  // return searched;

  return filtered;
});

final filteredAccountNodesProvider = Provider<Set<AccountNode>>((ref) {
  final accounts = ref.watch(accountsProvider);
  final filter = ref.watch(filterProvider);
  // final term = ref.watch(searchTermProvider);

  bool Function(AccountNode) getGeoSelectionFunction(String geoSelection) {
    return geoSelection == "All"
        ? (p0) => true
        : (p0) => p0.squadNode.marketNode.geoNode.name == geoSelection;
  }

  bool Function(AccountNode) getMarketSelectionFunction(
      String marketSelection) {
    return marketSelection == "All"
        ? (p0) => true
        : (p0) => p0.squadNode.marketNode.name == marketSelection;
  }

  bool Function(AccountNode) getSquadSelectionFunction(
    String squadSelection,
  ) {
    return squadSelection == "All"
        ? (p0) => true
        : (p0) => p0.squadNode.name == squadSelection;
  }

  bool Function(AccountNode) getAccountSelectionFunction(
    String accountSelection,
  ) {
    return accountSelection == "All"
        ? (p0) => true
        : (p0) => p0.name == accountSelection;
  }

  bool Function(AccountNode) accountSelectionFunction =
      getAccountSelectionFunction(filter.accountSelection);
  bool Function(AccountNode) squadSelectionFunction =
      getSquadSelectionFunction(filter.squadSelection);
  bool Function(AccountNode) marketSelectionFunction =
      getMarketSelectionFunction(filter.marketSelection);
  bool Function(AccountNode) geoSelectionFunction =
      getGeoSelectionFunction(filter.geoSelection);

  final filtered = accounts
      .where((a) =>
          accountSelectionFunction(a) &&
          squadSelectionFunction(a) &&
          marketSelectionFunction(a) &&
          geoSelectionFunction(a))
      .toSet();

  // final searched = filtered.toList().where((a) => a.search(term)).toSet();

  // return searched;

  return filtered;
});

final filteredProjectNodesProvider = Provider<Set<ProjectNode>>((ref) {
  final projects = ref.watch(projectsProvider);
  final filter = ref.watch(filterProvider);
  // final term = ref.watch(searchTermProvider);

  bool Function(ProjectNode) getGeoSelectionFunction(String geoSelection) {
    return geoSelection == "All"
        ? (p0) => true
        : (p0) => p0.account.squadNode.marketNode.geoNode.name == geoSelection;
  }

  bool Function(ProjectNode) getMarketSelectionFunction(
      String marketSelection) {
    return marketSelection == "All"
        ? (p0) => true
        : (p0) => p0.account.squadNode.marketNode.name == marketSelection;
  }

  bool Function(ProjectNode) getSquadSelectionFunction(
    String squadSelection,
  ) {
    return squadSelection == "All"
        ? (p0) => true
        : (p0) => p0.account.squadNode.name == squadSelection;
  }

  bool Function(ProjectNode) getAccountSelectionFunction(
    String accountSelection,
  ) {
    return accountSelection == "All"
        ? (p0) => true
        : (p0) => p0.account.name == accountSelection;
  }

  bool Function(ProjectNode) accountSelectionFunction =
      getAccountSelectionFunction(filter.accountSelection);
  bool Function(ProjectNode) squadSelectionFunction =
      getSquadSelectionFunction(filter.squadSelection);
  bool Function(ProjectNode) marketSelectionFunction =
      getMarketSelectionFunction(filter.marketSelection);
  bool Function(ProjectNode) geoSelectionFunction =
      getGeoSelectionFunction(filter.geoSelection);

  final filtered = projects
      .where((p) =>
          accountSelectionFunction(p) &&
          squadSelectionFunction(p) &&
          marketSelectionFunction(p) &&
          geoSelectionFunction(p))
      .toSet();

  // final searched = filtered.toList().where((a) => a.search(term)).toSet();

  // return searched;
  return filtered;
});
