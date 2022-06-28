import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/node_data.dart';
import 'package:cemindmap_ui/providers/graph_provider.dart';
import 'package:cemindmap_ui/widgets/account_filter_widget.dart';
import 'package:cemindmap_ui/widgets/geo_filiter_widget.dart';
import 'package:cemindmap_ui/widgets/node_widget.dart';
import 'package:cemindmap_ui/widgets/view_by_widget.dart';
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
    final graphProvider =
        StateNotifierProvider<GraphState, Graph>((_) => GraphState(ref));

    final graph = ref.watch(graphProvider);

    var builder = BuchheimWalkerConfiguration();

    if (graph.nodeCount() < 1) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              ViewByWidget(),
              const GeoFilterWidget(),
              const AccountFilterWidget(),
            ],
          ),
          Expanded(
            child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(8),
                minScale: 0.0001,
                maxScale: 0.5,
                scaleFactor: 50.0,
                child: GraphView(
                    graph: graph,
                    // algorithm: BuchheimWalkerAlgorithm(
                    //     BuchheimWalkerConfiguration(), ArrowEdgeRenderer()),
                    // algorithm: SugiyamaAlgorithm(SugiyamaConfiguration()),
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.green
                      ..strokeWidth = 1
                      ..style = PaintingStyle.fill,
                    builder: (Node node) {
                      var nd = node.key!.value as NodeData;

                      return NodeWidget(nodeData: nd);
                    })),
          ),
        ],
      ),
    );
  }
}
