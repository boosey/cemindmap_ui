import 'package:cemindmap_ui/providers/filtered_nodes_providers.dart';
import 'package:cemindmap_ui/widgets/section.dart';
import 'package:cemindmap_ui/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TiledDisplay extends HookConsumerWidget {
  TiledDisplay({
    Key? key,
  }) : super(key: key);

  final geosDisplayCountProvider = StateProvider<int>((ref) => 50);
  final marketsDisplayCountProvider = StateProvider<int>((ref) => 50);
  final squadsDisplayCountProvider = StateProvider<int>((ref) => 50);
  final accountsDisplayCountProvider = StateProvider<int>((ref) => 50);
  final projectsDisplayCountProvider = StateProvider<int>((ref) => 50);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredGeos = ref.watch(filteredGeoNodesProvider);
    final filteredMarkets = ref.watch(filteredMarketNodesProvider);
    final filteredSquads = ref.watch(filteredSquadNodesProvider);
    final filteredAccounts = ref.watch(filteredAccountNodesProvider);
    final filteredProjects = ref.watch(filteredProjectNodesProvider);

    return CustomScrollView(slivers: <Widget>[
      Section(
          sectionTitle: "Geographies",
          nodeDisplayCountProvider: geosDisplayCountProvider,
          nodeWidgets: filteredGeos.map((g) => GeoTile(node: g)).toList()),
      Section(
          sectionTitle: "Markets",
          nodeDisplayCountProvider: marketsDisplayCountProvider,
          nodeWidgets: filteredMarkets
              .map((m) => MarketTile(node: m))
              .toList()), //   section(
      Section(
          sectionTitle: "Squads",
          nodeDisplayCountProvider: squadsDisplayCountProvider,
          nodeWidgets: filteredSquads.map((s) => SquadTile(node: s)).toList()),
      Section(
          sectionTitle: "Accounts",
          nodeDisplayCountProvider: accountsDisplayCountProvider,
          nodeWidgets:
              filteredAccounts.map((a) => AccountTile(node: a)).toList()),
      Section(
          sectionTitle: "Projects",
          nodeDisplayCountProvider: projectsDisplayCountProvider,
          nodeWidgets:
              filteredProjects.map((p) => ProjectTile(node: p)).toList()),
    ]);
  }
}
