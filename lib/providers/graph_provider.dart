// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/node_data.dart';
import 'package:cemindmap_ui/providers/view_by_selection.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../models/project.dart';

class GraphState extends StateNotifier<Graph> {
  GraphState(this.ref) : super(Graph()) {
    projects = ref.projects.watchAll();
    viewBySelection = ref.watch(viewBySelectionProvider);
    state = createGraph();
  }
  WidgetRef ref;
  late DataState<List<Project>?> projects;
  late ViewByChoice viewBySelection;

  Graph createGraph() {
    var graph = Graph();
    graph.isTree = true;

    Node root =
        Node.Id(NodeData(key: "root", isRoot: true, project: Project()));

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
      var nodeData = NodeData(key: childKey(p), isProject: false);
      if (currentLayerSet.add(nodeData)) {
        graph.addEdge(
          Node.Id(parentLayerSet.firstWhere((d) => d.key == parentKey(p))),
          Node.Id(nodeData),
        );
      }
    }
    return currentLayerSet;
  }

  Set<NodeData> geoLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(
        graph, parentLayerSet, (parent) => "root", (child) => child.geo!);
  }

  Set<NodeData> marketLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet, (parent) => parent.geo!,
        (child) => child.market!);
  }

  Set<NodeData> squadLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet, (parent) => parent.market!,
        (child) => child.geoMarketSquad!);
  }

  Set<NodeData> accountLayer(Graph graph, Set<NodeData> parentLayerSet) {
    return buildGraphLayer(graph, parentLayerSet,
        (parent) => parent.geoMarketSquad!, (child) => child.accountName!);
  }

  Graph graphByOrganization(Graph graph, Node root) {
    var accountNodeDataSet = accountLayer(
      graph,
      squadLayer(
        graph,
        marketLayer(
          graph,
          geoLayer(
            graph,
            <NodeData>{root.key!.value},
          ),
        ),
      ),
    );

    for (var p in projects.model!) {
      graph.addEdge(
          Node.Id(accountNodeDataSet.firstWhere((s) => s.key == p.accountName)),
          Node.Id(NodeData(key: p.projectName!, isProject: true, project: p)));
    }

    return graph;
  }
}
