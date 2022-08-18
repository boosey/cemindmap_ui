import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/widgets/filter_bar.dart';
import 'package:cemindmap_ui/widgets/search_widget.dart';
import 'package:cemindmap_ui/widgets/section_toggles.dart';
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
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FilterBar(),
          Row(
            children: const [
              SectionTogglesWidget(),
              Expanded(child: SearchBar()),
            ],
          ),
          Expanded(
            child: TiledDisplay(),
          )
        ],
      ),
    );
  }
}
