import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter_data/flutter_data.dart';

import '../nodes/squad_node.dart';

part 'filter_provider.g.dart';

const allString = "All";
final seedSet = {allString};

@CopyWith()
class Filter {
  final Set<GeoNode> allGeoNodes;
  final Set<MarketNode> allMarketNodes;
  final Set<SquadNode> allSquadNodes;
  final Set<AccountNode> allAccountNodes;

  final String geoSelection;
  final String marketSelection;
  final String squadSelection;
  final String accountSelection;

  Filter({
    this.geoSelection = allString,
    this.marketSelection = allString,
    this.squadSelection = allString,
    this.accountSelection = allString,
    required this.allGeoNodes,
    required this.allMarketNodes,
    required this.allSquadNodes,
    required this.allAccountNodes,
  });

  Set<String> get geoOptions =>
      {allString}..addAll(allGeoNodes.map((e) => e.name));

  Set<String> get marketOptions => {allString}..addAll(allMarketNodes
      .where(
          (n) => (n.geoNode.name == geoSelection || geoSelection == allString))
      .map((e) => e.name));

  Set<String> get squadOptions => {allString}..addAll(allSquadNodes
      .where((n) =>
          (n.marketNode.geoNode.name == geoSelection ||
              geoSelection == allString) &&
          (n.marketNode.name == marketSelection ||
              marketSelection == allString))
      .map((e) => e.name));

  Set<String> get accountOptions => {allString}..addAll(allAccountNodes
      .where((n) =>
          (n.squadNode.marketNode.geoNode.name == geoSelection ||
              geoSelection == allString) &&
          (n.squadNode.marketNode.name == marketSelection ||
              marketSelection == allString) &&
          (n.squadNode.name == squadSelection || squadSelection == allString))
      .map((e) => e.name));
}

class FilterNotifier extends StateNotifier<Filter> {
  FilterNotifier({
    required allGeoNodes,
    required allMarketNodes,
    required allSquadNodes,
    required allAccountNodes,
  }) : super(Filter(
          allAccountNodes: allAccountNodes,
          allMarketNodes: allMarketNodes,
          allGeoNodes: allGeoNodes,
          allSquadNodes: allSquadNodes,
        ));

  set geoSelection(String s) => state = state.copyWith(
        geoSelection: s,
        marketSelection: allString,
        squadSelection: allString,
        accountSelection: allString,
      );

  set marketSelection(String s) => state = state.copyWith(
        marketSelection: s,
        geoSelection: s == allString
            ? state.geoSelection
            : state.allMarketNodes.firstWhere((m) => m.name == s).geoNode.name,
        squadSelection: allString,
        accountSelection: allString,
      );

  set squadSelection(String s) => state = state.copyWith(
        squadSelection: s,
        geoSelection: s == allString
            ? state.geoSelection
            : state.allSquadNodes
                .firstWhere((q) => q.name == s)
                .marketNode
                .geoNode
                .name,
        marketSelection: s == allString
            ? state.marketSelection
            : state.allSquadNodes
                .firstWhere((q) => q.name == s)
                .marketNode
                .name,
        accountSelection: allString,
      );

  set accountSelection(String s) => state = state.copyWith(
        accountSelection: s,
        geoSelection: s == allString
            ? state.geoSelection
            : state.allAccountNodes
                .firstWhere((a) => a.name == s)
                .squadNode
                .marketNode
                .geoNode
                .name,
        marketSelection: s == allString
            ? state.marketSelection
            : state.allAccountNodes
                .firstWhere((a) => a.name == s)
                .squadNode
                .marketNode
                .name,
        squadSelection: s == allString
            ? state.squadSelection
            : state.allAccountNodes
                .firstWhere((a) => a.name == s)
                .squadNode
                .name,
      );
}

final filterProvider = StateNotifierProvider<FilterNotifier, Filter>((ref) {
  final allGeoNodes = ref.watch(geosProvider);
  final allMarketNodes = ref.watch(marketsProvider);
  final allSquadNodes = ref.watch(squadsProvider);
  final allAccountNodes = ref.watch(accountsProvider);

  return FilterNotifier(
      allGeoNodes: allGeoNodes,
      allMarketNodes: allMarketNodes,
      allSquadNodes: allSquadNodes,
      allAccountNodes: allAccountNodes);
});
