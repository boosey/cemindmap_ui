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

const geoTileColor = Colors.blueAccent;
const marketTileColor = Color.fromARGB(255, 167, 146, 203);
const squadTileColor = Color.fromARGB(255, 155, 63, 198);
const accountTileColor = Colors.lightGreen;
const projectTileColor = Colors.green;

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
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            Section(
              sectionTitle: "Geographies",
              nodeDisplayCountProvider: geosDisplayCountProvider,
              filteredNodesProvider: filteredGeoNodesProvider,
              moreButtonColor: geoTileColor,
              delegate: (g) => GeoTile(
                key: Key(g.name),
                node: g as GeoNode,
                color: geoTileColor,
              ),
            ),
            Section(
              sectionTitle: "Markets",
              nodeDisplayCountProvider: marketsDisplayCountProvider,
              filteredNodesProvider: filteredMarketNodesProvider,
              moreButtonColor: marketTileColor,
              delegate: (g) => MarketTile(
                key: Key(g.name),
                node: g as MarketNode,
                color: marketTileColor,
              ),
            ),
            Section(
              sectionTitle: "Squads",
              nodeDisplayCountProvider: squadsDisplayCountProvider,
              filteredNodesProvider: filteredSquadNodesProvider,
              moreButtonColor: squadTileColor,
              delegate: (g) => SquadTile(
                key: Key(g.name),
                node: g as SquadNode,
                color: squadTileColor,
              ),
            ),
            Section(
              sectionTitle: "Accounts",
              nodeDisplayCountProvider: accountsDisplayCountProvider,
              filteredNodesProvider: filteredAccountNodesProvider,
              moreButtonColor: accountTileColor,
              delegate: (g) => AccountTile(
                key: Key(g.name),
                node: g as AccountNode,
                color: accountTileColor,
              ),
            ),
            Section(
              sectionTitle: "Projects",
              nodeDisplayCountProvider: projectsDisplayCountProvider,
              filteredNodesProvider: filteredProjectNodesProvider,
              moreButtonColor: projectTileColor,
              delegate: (g) => ProjectTile(
                key: Key(g.name),
                node: g as ProjectNode,
                color: projectTileColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
