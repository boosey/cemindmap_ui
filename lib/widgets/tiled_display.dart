import 'package:cemindmap_ui/providers/filtered_nodes_provider.dart';
import 'package:cemindmap_ui/widgets/section.dart';
import 'package:cemindmap_ui/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../nodes/account_node.dart';
import '../nodes/geo_node.dart';
import '../nodes/market_node.dart';
import '../nodes/project_node.dart';
import '../nodes/squad_node.dart';

class TiledDisplay extends HookConsumerWidget {
  TiledDisplay({
    Key? key,
  }) : super(key: key);

  final accountsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final geosDisplayCountProvider = StateProvider<int>((ref) => 25);
  final marketsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final projectsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final squadsDisplayCountProvider = StateProvider<int>((ref) => 25);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: <Widget>[
        Section(
          sectionTitle: "Geographies",
          nodeDisplayCountProvider: geosDisplayCountProvider,
          filteredNodesProvider: filteredGeoNodesProvider,
          delegate: (g) => GeoTile(node: g as GeoNode),
        ),
        Section(
          sectionTitle: "Markets",
          nodeDisplayCountProvider: marketsDisplayCountProvider,
          filteredNodesProvider: filteredMarketNodesProvider,
          delegate: (g) => MarketTile(node: g as MarketNode),
        ),
        Section(
          sectionTitle: "Squads",
          nodeDisplayCountProvider: squadsDisplayCountProvider,
          filteredNodesProvider: filteredSquadNodesProvider,
          delegate: (g) => SquadTile(node: g as SquadNode),
        ),
        Section(
          sectionTitle: "Accounts",
          nodeDisplayCountProvider: accountsDisplayCountProvider,
          filteredNodesProvider: filteredAccountNodesProvider,
          delegate: (g) => AccountTile(node: g as AccountNode),
        ),
        Section(
          sectionTitle: "Projects",
          nodeDisplayCountProvider: projectsDisplayCountProvider,
          filteredNodesProvider: filteredProjectNodesProvider,
          delegate: (g) => ProjectTile(node: g as ProjectNode),
        ),
      ],
    );
  }
}
