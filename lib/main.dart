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

    return RefreshIndicator(
      onRefresh: () => ref.read(provider.notifier).reload(),
      child: ListView(
        children: (projects.model ?? [])
            .map(
              (project) => ListTile(
                title: Text('${project.projectName}'),
              ),
            )
            .toList(),
      ),
    );
  }

  Graph buildGraph(List<Project> projects) {
    var graph = Graph();

    Node root = Node.Id('Projects');
    for (var p in projects) {
      graph.addEdge(root, Node.Id(p.projectName));
    }

    return graph;
  }
}
