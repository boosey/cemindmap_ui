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

    Node root =
        Node.Id(NodeData(key: "root", isRoot: true, project: Project()));

    if (projects.hasModel) {
      switch (viewBySelection) {
        case ViewByChoice.organization:
          return geoGraph(graph, root);

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

  Graph geoGraph(Graph graph, Node root) {
    var geoNodeDataSet = <NodeData>{};
    var marketNodeDataSet = <NodeData>{};
    var squadNodeDataSet = <NodeData>{};

    for (var p in projects.model!) {
      var geoNodeData = NodeData(key: p.geo!);
      if (geoNodeDataSet.add(geoNodeData)) {
        graph.addEdge(
          root,
          Node.Id(geoNodeData),
        );
      }
    }

    for (var p in projects.model!) {
      var marketNodeData = NodeData(key: p.market!);
      if (marketNodeDataSet.add(marketNodeData)) {
        graph.addEdge(
          Node.Id(geoNodeDataSet.firstWhere((g) => g.key == p.geo)),
          Node.Id(marketNodeData),
        );
      }
    }

    for (var p in projects.model!) {
      var squadNodeData = NodeData(key: p.geoMarketSquad!);
      if (squadNodeDataSet.add(squadNodeData)) {
        graph.addEdge(
          Node.Id(marketNodeDataSet.firstWhere((m) => m.key == p.market)),
          Node.Id(squadNodeData),
        );
      }
    }

    for (var p in projects.model!) {
      graph.addEdge(
          Node.Id(
              squadNodeDataSet.firstWhere((s) => s.key == p.geoMarketSquad)),
          Node.Id(NodeData(key: p.projectId!, isProject: true, project: p)));
    }

    return graph;
  }
}
