import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/providers/filtered_nodes_providers.dart';
import 'package:cemindmap_ui/widgets/filter_bar.dart';
import 'package:cemindmap_ui/widgets/tiled_display.dart';
import 'package:flutter/material.dart';
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
    final filteredProjects = ref.watch(filteredProjectNodesProvider);

    if (filteredProjects.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const FilterBar(),
          Expanded(
            child: TiledDisplay(),
          )
        ],
      ),
    );
  }
}
