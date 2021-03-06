// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.

import 'package:cemindmap_ui/node_data.dart';
import 'package:cemindmap_ui/providers/view_by_selection.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:graphview/GraphView.dart';
import '../models/project.dart';

class GraphState extends StateNotifier<Graph> {
  GraphState({
    required this.projects,
    required this.viewBySelection,
    required this.geoSelection,
    required this.marketSelection,
    required this.squadSelection,
    required this.accountSelection,
  }) : super(Graph()..addNode(Node.Id(NodeData(key: "root", isRoot: true)))) {
    state = createGraph();
  }

  final DataState<List<Project>?> projects;
  final ViewByChoice viewBySelection;
  final String geoSelection;
  final String marketSelection;
  final String squadSelection;
  final String accountSelection;

  Graph createGraph() {
    var graph = Graph();
    graph.isTree = true;

    Node root = Node.Id(NodeData(key: "root", isRoot: true));
    // graph.addNode(root);

    if (projects.hasModel) {
      switch (viewBySelection) {
        case ViewByChoice.organization:
          return graphByOrganization(graph, root);

        case ViewByChoice.projectLeader:
          // TODO: Handle this case.
          break;
        case ViewByChoice.account:
          // TODO: Handle this case.
          break;
      }
    }
    return graph;
  }

  Set<NodeData> buildGraphLayer(Graph graph, Set<NodeData> parentLayerSet,
      String Function(Project) parentKey, String Function(Project) childKey) {
    var currentLayerSet = <NodeData>{};

    for (var p in projects.model!) {
      if (p.geo == geoSelection &&
          (p.market == marketSelection || marketSelection == "All") &&
          (p.geoMarketSquad == squadSelection || squadSelection == "All")) {
        var nodeData = NodeData(key: childKey(p), isProject: false);
        if (currentLayerSet.add(nodeData)) {
          graph.addEdge(
            Node.Id(parentLayerSet.firstWhere((d) => d.key == parentKey(p))),
            Node.Id(nodeData),
          );
        }
      }
    }

    return currentLayerSet;
  }

  Set<NodeData> createGeoLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(
        graph, parentLayerSet, (parent) => "root", (child) => child.geo!);
  }

  Set<NodeData> createMarketLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet, (parent) => parent.geo!,
        (child) => child.market!);
  }

  Set<NodeData> createSquadLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet, (parent) => parent.market!,
        (child) => child.geoMarketSquad!);
  }

  Set<NodeData> createAccountLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet,
        (parent) => parent.geoMarketSquad!, (child) => child.accountName!);
  }

  Graph graphByOrganization(Graph graph, Node root) {
    var geoLayer = createGeoLayer(
      graph,
      <NodeData>{root.key!.value},
    );

    var marketLayer = createMarketLayer(
      graph,
      geoLayer,
    );

    var squadLayer = createSquadLayer(
      graph,
      marketLayer,
    );

    if (marketSelection != "All") {
      var accountNodeDataSet = createAccountLayer(graph, squadLayer);

      for (var p in projects.model!) {
        if (accountNodeDataSet.isNotEmpty &&
            p.geo == geoSelection &&
            (p.market == marketSelection) &&
            (p.geoMarketSquad == squadSelection || squadSelection == "All")) {
          graph.addEdge(
              Node.Id(
                  accountNodeDataSet.firstWhere((s) => s.key == p.accountName)),
              Node.Id(
                  NodeData(key: p.projectName!, isProject: true, project: p)));
        }
      }
    }
    return graph;
  }
}
