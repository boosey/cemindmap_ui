import 'package:cemindmap_ui/providers/detail_widgets_provider.dart';
import 'package:cemindmap_ui/providers/filtered_nodes_provider.dart';
import 'package:cemindmap_ui/providers/view_settings_provider.dart';
import 'package:cemindmap_ui/widgets/section.dart';
import 'package:cemindmap_ui/widgets/tiles.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../nodes/account_node.dart';
import '../nodes/geo_node.dart';
import '../nodes/market_node.dart';
import '../nodes/project_node.dart';
import '../nodes/squad_node.dart';
import '../nodes/talent_node.dart';

const geoTileColor = Color.fromARGB(255, 0xed, 0xf5, 0xff);
const geoTileTextColor = Colors.black;
const marketTileColor = Color.fromARGB(255, 0xd0, 0xe2, 0xff);
const marketTileTextColor = Colors.black;
const squadTileColor = Color.fromARGB(255, 0xa6, 0xc8, 0xff);
const squadTileTextColor = Colors.black;
const accountTileColor = Color.fromARGB(255, 0x78, 0xa9, 0xff);
const accountTileTextColor = Colors.black;
const projectTileColor = Color.fromARGB(255, 0x45, 0x89, 0xff);
const projectTileTextColor = Colors.white;
const assignmentTileColor = Color.fromARGB(255, 0x57, 0x04, 0x08);
const talentTileColor = Color.fromARGB(255, 0x0f, 0x62, 0xfe);
const talentTileTextColor = Colors.white;

class TiledDisplay extends HookConsumerWidget {
  TiledDisplay({
    Key? key,
  }) : super(key: key);

  final accountsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final geosDisplayCountProvider = StateProvider<int>((ref) => 25);
  final marketsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final projectsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final squadsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final assignmentsDisplayCountProvider = StateProvider<int>((ref) => 25);
  final talentDisplayCountProvider = StateProvider<int>((ref) => 25);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailWidgets = ref.watch(detailWidgetsProvider);
    final showSectionsFlags =
        ref.watch(viewSettingsProvider)[ViewSettings.showSectionsFlags]
            as List<bool>;
    return Stack(
      children: [
        CustomScrollView(
          slivers: <Widget>[
            SliverVisibility(
              visible: showSectionsFlags[0],
              sliver: Section(
                sectionTitle: "Geographies",
                nodeDisplayCountProvider: geosDisplayCountProvider,
                filteredNodesProvider: filteredGeoNodesProvider,
                moreButtonColor: geoTileColor,
                delegate: (g) => GeoTile(
                  key: Key(g.name),
                  node: g as GeoNode,
                  color: geoTileColor,
                  textColor: geoTileTextColor,
                ),
              ),
            ),
            SliverVisibility(
              visible: showSectionsFlags[1],
              sliver: Section(
                sectionTitle: "Markets",
                nodeDisplayCountProvider: marketsDisplayCountProvider,
                filteredNodesProvider: filteredMarketNodesProvider,
                moreButtonColor: marketTileColor,
                delegate: (g) => MarketTile(
                  key: Key(g.name),
                  node: g as MarketNode,
                  color: marketTileColor,
                  textColor: marketTileTextColor,
                ),
              ),
            ),
            SliverVisibility(
              visible: showSectionsFlags[2],
              sliver: Section(
                sectionTitle: "Squads",
                nodeDisplayCountProvider: squadsDisplayCountProvider,
                filteredNodesProvider: filteredSquadNodesProvider,
                moreButtonColor: squadTileColor,
                delegate: (g) => SquadTile(
                  key: Key(g.name),
                  node: g as SquadNode,
                  color: squadTileColor,
                  textColor: squadTileTextColor,
                ),
              ),
            ),
            SliverVisibility(
              visible: showSectionsFlags[3],
              sliver: Section(
                sectionTitle: "Accounts",
                nodeDisplayCountProvider: accountsDisplayCountProvider,
                filteredNodesProvider: filteredAccountNodesProvider,
                moreButtonColor: accountTileColor,
                delegate: (g) => AccountTile(
                  key: Key(g.name),
                  node: g as AccountNode,
                  color: accountTileColor,
                  textColor: accountTileTextColor,
                ),
              ),
            ),
            SliverVisibility(
              visible: showSectionsFlags[4],
              sliver: Section(
                sectionTitle: "Projects",
                nodeDisplayCountProvider: projectsDisplayCountProvider,
                filteredNodesProvider: filteredProjectNodesProvider,
                moreButtonColor: projectTileColor,
                delegate: (g) => ProjectTile(
                  key: Key(g.name),
                  node: g as ProjectNode,
                  color: projectTileColor,
                  textColor: projectTileTextColor,
                ),
              ),
            ),
            SliverVisibility(
              visible: showSectionsFlags[5],
              sliver: Section(
                sectionTitle: "Talent",
                nodeDisplayCountProvider: talentDisplayCountProvider,
                filteredNodesProvider: filteredtalentNodesProvider,
                moreButtonColor: talentTileColor,
                delegate: (g) => TalentTile(
                  key: Key(g.name),
                  node: g as TalentNode,
                  color: talentTileColor,
                  textColor: talentTileTextColor,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 700)),
          ],
        ),
        ...detailWidgets.values,
      ],
    );
  }
}
