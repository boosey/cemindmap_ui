import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/assignment_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:cemindmap_ui/nodes/talent_node.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:cemindmap_ui/providers/filter_provider.dart';
import 'package:flutter_data/flutter_data.dart';

class FilteredNodes {
  FilteredNodes(
      {required this.geoNodes,
      required this.marketNodes,
      required this.squadNodes,
      required this.accountNodes,
      required this.assignmentNodes,
      required this.talentNodes,
      required this.projectNodes});

  final Set<AccountNode> accountNodes;
  final Set<GeoNode> geoNodes;
  final Set<MarketNode> marketNodes;
  final Set<ProjectNode> projectNodes;
  final Set<SquadNode> squadNodes;
  final Set<AssignmentNode> assignmentNodes;
  final Set<TalentNode> talentNodes;
}

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

final filteredNodesProvider = Provider<FilteredNodes>((ref) {
  final geos = ref.watch(allGeosProvider);
  final markets = ref.watch(allMarketsProvider);
  final squads = ref.watch(allSquadsProvider);
  final accounts = ref.watch(allAccountsProvider);
  final projects = ref.watch(allProjectsProvider);
  final assignments = ref.watch(allAssignmentsProvider);
  final talent = ref.watch(allTalentProvider);
  final filter = ref.watch(filterProvider);

  final geoNodes = geos
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (GeoNode n) => isAllOrMatches(filter.geoSelection, n.name),
        ),
      )
      .toSet();

  final marketNodes = markets
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (MarketNode n) =>
              isAllOrMatches(filter.marketSelection, n.name) &&
              isAllOrMatches(filter.geoSelection, n.geoNode.name),
        ),
      )
      .toSet();

  final squadNodes = squads
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

  final accountNodes = accounts
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

  final projectNodes = projects
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

  final assignmentNodes = assignments
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (AssignmentNode n) =>
              isAllOrMatches(
                  filter.accountSelection, n.projectNode.account.name) &&
              isAllOrMatches(filter.squadSelection,
                  n.projectNode.account.squadNode.name) &&
              isAllOrMatches(filter.marketSelection,
                  n.projectNode.account.squadNode.marketNode.name) &&
              isAllOrMatches(filter.geoSelection,
                  n.projectNode.account.squadNode.marketNode.geoNode.name),
        ),
      )
      .toSet();

  final talentNodes = talent
      .where(
        (node) => passesFilter(
          node,
          filter.searchTerms,
          (TalentNode n) => true,
        ),
      )
      .toSet();

  if (filter.searchTerms.isNotEmpty && filter.searchTerms.length >= 3) {
    for (var m in marketNodes) {
      geoNodes.add(m.geoNode);
    }

    for (var q in squadNodes) {
      marketNodes.add(q.marketNode);
      geoNodes.add(q.marketNode.geoNode);
    }

    for (var a in accountNodes) {
      squadNodes.add(a.squadNode);
      marketNodes.add(a.squadNode.marketNode);
      geoNodes.add(a.squadNode.marketNode.geoNode);
    }
    for (var p in projectNodes) {
      accountNodes.add(p.account);
      squadNodes.add(p.account.squadNode);
      marketNodes.add(p.account.squadNode.marketNode);
      geoNodes.add(p.account.squadNode.marketNode.geoNode);
    }
  }

  return FilteredNodes(
      geoNodes: geoNodes,
      marketNodes: marketNodes,
      squadNodes: squadNodes,
      accountNodes: accountNodes,
      assignmentNodes: assignmentNodes,
      talentNodes: talentNodes,
      projectNodes: projectNodes);
});

final filteredGeoNodesProvider = Provider<Set<GeoNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.geoNodes;
});

final filteredMarketNodesProvider = Provider<Set<MarketNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.marketNodes;
});

final filteredSquadNodesProvider = Provider<Set<SquadNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.squadNodes;
});

final filteredAccountNodesProvider = Provider<Set<AccountNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.accountNodes;
});

final filteredProjectNodesProvider = Provider<Set<ProjectNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.projectNodes;
});

final filteredAssignmentNodesProvider = Provider<Set<AssignmentNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.assignmentNodes;
});

final filteredtalentNodesProvider = Provider<Set<TalentNode>>((ref) {
  final filteredNodes = ref.watch(filteredNodesProvider);

  return filteredNodes.talentNodes;
});
