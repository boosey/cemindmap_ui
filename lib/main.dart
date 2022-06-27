import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/models/project.dart';
import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      overrides: [configureRepositoryLocalStorage()],
      child: const MindMapApp(),
    ),
  );
}

class MindMapApp extends HookConsumerWidget {
  const MindMapApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ref.watch(repositoryInitializerProvider).when(
                error: (error, _) => Text(error.toString()),
                loading: () => const CircularProgressIndicator(),
                data: (_) => const MindMap(),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MindMap extends HookConsumerWidget {
  const MindMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // NOTE: here we could use `ref.tasks.watchAll()` but we
    // break it down in provider + watch in order to access the
    // notifier below (onRefresh)
    final provider = ref.projects.watchAllProvider(syncLocal: true);
    final projects = ref.watch(provider);

    if (projects.isLoading) {
      return const CircularProgressIndicator();
    }

    return InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(8),
        minScale: 0.0001,
        maxScale: 0.5,
        scaleFactor: 50.0,
        child: GraphView(
            graph: buildGraph(projects.model ?? []),
            // algorithm: BuchheimWalkerAlgorithm(
            //     BuchheimWalkerConfiguration(), ArrowEdgeRenderer()),
            algorithm: SugiyamaAlgorithm(SugiyamaConfiguration()),
            paint: Paint()
              ..color = Colors.green
              ..strokeWidth = 1
              ..style = PaintingStyle.fill,
            builder: (Node node) {
              // I can decide what widget should be shown here based on the id
              var a = node.key!.value as int?;
              if (a == 2) {
                return rectangWidget(node.key);
              }
              return rectangWidget(a);
            }));
  }

  Graph buildGraph(List<Project> projects) {
    var graph = Graph();

    Node root = Node.Id(-1);
    var i = 0;
    // ignore: unused_local_variable
    for (var p in projects) {
      graph.addEdge(root, Node.Id(i++));
    }

    return graph;
  }

  Widget rectangWidget(dynamic id) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Text(id.toString()));
  }
}
