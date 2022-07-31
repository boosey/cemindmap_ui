import 'package:cemindmap_ui/models/raw_assignment.dart';
import 'package:cemindmap_ui/models/raw_project.dart';
import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:cemindmap_ui/nodes/assignment_node.dart';
import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:cemindmap_ui/nodes/talent_node.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:cemindmap_ui/main.data.dart';

class NodesFromRawData {
  /// Geos, Markets, Squads, and Accounts are derived from the raw project data
  /// imported from ISC. Since we are creating Sets of data rather than Lists
  /// We insert each derived node into the appropriate Set. Since it is a set
  /// and we've overridden the == and hash function on each node type, if the
  /// node is already in the set, it is never actually added twice. This
  /// provides us the sets of node types with each node being unique.

  NodesFromRawData({
    required List<RawProject> rawProjects,
    required List<RawAssignment> rawAssignments,
  }) {
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
    }

    for (var rawAssignment in rawAssignments) {
      final currentTalent =
          TalentNode.fromRawAssignment(rawAssignment: rawAssignment);
      talent.add(currentTalent);

      try {
        final p = projects.firstWhere(
          (p1) => p1.rawProject.projectId == rawAssignment.projectId,
        );
        final currentAssignment = AssignmentNode.fromRawAssignment(
            rawAssignment: rawAssignment,
            projectNode: p,
            talentNode: currentTalent);

        assignments.add(currentAssignment);
      } on StateError catch (_) {
        // log("No project for assignment: ${rawAssignment.assignmentId} / ${rawAssignment.assignmentName} Error: $e");
      }
    }
  }

  final Set<AccountNode> accounts = {};
  final Set<GeoNode> geos = {};
  final Set<MarketNode> markets = {};
  final Set<ProjectNode> projects = {};
  final Set<SquadNode> squads = {};
  final Set<TalentNode> talent = {};
  final Set<AssignmentNode> assignments = {};
}

final nodesFromRawDataProvider = Provider<NodesFromRawData>((ref) {
  final rawProjects = ref.rawProjects.watchAll();
  final rawAssignments = ref.rawAssignments.watchAll();

  return NodesFromRawData(
    rawProjects: rawProjects.hasModel ? rawProjects.model! : [],
    rawAssignments: rawAssignments.hasModel ? rawAssignments.model! : [],
  );
});

final allGeosProvider = Provider<Set<GeoNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.geos;
});

final allMarketsProvider = Provider<Set<MarketNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.markets;
});

final allSquadsProvider = Provider<Set<SquadNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.squads;
});

final allAccountsProvider = Provider<Set<AccountNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.accounts;
});

final allProjectsProvider = Provider<Set<ProjectNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.projects;
});

final allAssignmentsProvider = Provider<Set<AssignmentNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.assignments;
});

final allTalentProvider = Provider<Set<TalentNode>>((ref) {
  final nodes = ref.watch(nodesFromRawDataProvider);
  return nodes.talent;
});
