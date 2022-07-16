import 'package:cemindmap_ui/models/raw_project.dart';
import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
// import 'package:cemindmap_ui/nodes/ww_node.dart.disabled';
import 'package:flutter_data/flutter_data.dart';
import 'package:cemindmap_ui/main.data.dart';

class NodesFromRawProjectsData {
  NodesFromRawProjectsData({required List<RawProject> rawProjects}) {
    // Create nodes from raw project data

    for (var rawProject in rawProjects) {
      final currentGeo = GeoNode.fromRawProject(rawProject: rawProject);
      final currentMarket = MarketNode.fromRawProject(
          rawProject: rawProject, geoNode: currentGeo);
      final currentSquad = SquadNode.fromRawProject(
          rawProject: rawProject, marketNode: currentMarket);
      final currentAccount = AccountNode.fromRawProject(
          rawProject: rawProject, squadNode: currentSquad);
      final currentProject = ProjectNode.fromRawProject(
          rawProject: rawProject, account: currentAccount);

      geos.add(currentGeo);
      markets.add(currentMarket);
      squads.add(currentSquad);
      accounts.add(currentAccount);
      projects.add(currentProject);

      // if (projects.length >= 100) {
      //   break;
      // }
    }
  }

  final Set<AccountNode> accounts = {};
  // final WWNode wwNode = WWNode(key: 'ww_node');
  final Set<GeoNode> geos = {};

  final Set<MarketNode> markets = {};
  final Set<ProjectNode> projects = {};
  final Set<SquadNode> squads = {};
}

class NodesFromRawProjectsDataStateNotifier
    extends StateNotifier<NodesFromRawProjectsData> {
  NodesFromRawProjectsDataStateNotifier(super.state);
}

final nodesFromRawProjectsDataProvider = StateNotifierProvider<
    NodesFromRawProjectsDataStateNotifier, NodesFromRawProjectsData>((ref) {
  final rawProjects = ref.rawProjects.watchAll();

  return NodesFromRawProjectsDataStateNotifier(NodesFromRawProjectsData(
      rawProjects: rawProjects.hasModel ? rawProjects.model! : []));
});

final allGeosProvider = Provider<Set<GeoNode>>((ref) {
  final nodes = ref.watch(nodesFromRawProjectsDataProvider);
  return nodes.geos;
});

final allMarketsProvider = Provider<Set<MarketNode>>((ref) {
  final nodes = ref.watch(nodesFromRawProjectsDataProvider);
  return nodes.markets;
});

final allSquadsProvider = Provider<Set<SquadNode>>((ref) {
  final nodes = ref.watch(nodesFromRawProjectsDataProvider);
  return nodes.squads;
});

final allAccountsProvider = Provider<Set<AccountNode>>((ref) {
  final nodes = ref.watch(nodesFromRawProjectsDataProvider);
  return nodes.accounts;
});

final allProjectsProvider = Provider<Set<ProjectNode>>((ref) {
  final nodes = ref.watch(nodesFromRawProjectsDataProvider);
  return nodes.projects;
});
