// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.
import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/project_node.dart';
import 'package:flutter_data/flutter_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphview/GraphView.dart';

import '../models/project.dart';

class GraphState extends StateNotifier<Graph> {
  GraphState(WidgetRef ref) : super(Graph()) {
    projects = ref.projects.watchAll();
    state = createGraph();
  }

  late DataState<List<Project>?> projects;

  Graph createGraph() {
    var graph = Graph();

    Node root = Node.Id(ProjectNodeData(isRoot: true, project: Project()));
    if (projects.hasModel) {
      for (var p in projects.model!) {
        graph.addEdge(root, Node.Id(ProjectNodeData(project: p)));
      }
    }
    return graph;
  }
}
