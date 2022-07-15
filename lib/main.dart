import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/providers/filter_provider.dart';
import 'package:cemindmap_ui/providers/filtered_nodes_providers.dart';
import 'package:cemindmap_ui/widgets/filter_widget.dart';
import 'package:cemindmap_ui/widgets/tiles.dart';
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
    final filteredGeos = ref.watch(filteredGeoNodesProvider);
    final filteredMarkets = ref.watch(filteredMarketNodesProvider);
    final filteredSquads = ref.watch(filteredSquadNodesProvider);
    final filteredAccounts = ref.watch(filteredAccountNodesProvider);
    final filteredProjects = ref.watch(filteredProjectNodesProvider);

    final filter = ref.watch(filterProvider);

    if (filteredProjects.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              FilterWidget(
                label: "Geography",
                items: filter.geoOptions,
                selected: filter.geoSelection,
                onChanged: (value) => ref
                    .read<FilterNotifier>(filterProvider.notifier)
                    .geoSelection = value,
              ),
              FilterWidget(
                label: "Market",
                items: filter.marketOptions,
                selected: filter.marketSelection,
                onChanged: (value) => ref
                    .read<FilterNotifier>(filterProvider.notifier)
                    .marketSelection = value,
              ),
              FilterWidget(
                label: "Squad",
                items: filter.squadOptions,
                selected: filter.squadSelection,
                onChanged: (value) => ref
                    .read<FilterNotifier>(filterProvider.notifier)
                    .squadSelection = value,
              ),
              FilterWidget(
                label: "Account",
                items: filter.accountOptions,
                selected: filter.accountSelection,
                onChanged: (value) => ref
                    .read<FilterNotifier>(filterProvider.notifier)
                    .accountSelection = value,
              ),
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <List<Widget>>[
                section(
                    context: context,
                    sectionTitle: "Geographies",
                    nodeWidgets:
                        filteredGeos.map((g) => GeoTile(node: g)).toList()),
                section(
                    context: context,
                    sectionTitle: "Markets",
                    nodeWidgets: filteredMarkets
                        .map((m) => MarketTile(node: m))
                        .toList()),
                section(
                    context: context,
                    sectionTitle: "Squads",
                    nodeWidgets:
                        filteredSquads.map((s) => SquadTile(node: s)).toList()),
                section(
                    context: context,
                    sectionTitle: "Accounts",
                    nodeWidgets: filteredAccounts
                        .map((a) => AccountTile(node: a))
                        .toList()),
                section(
                    context: context,
                    sectionTitle: "Projects",
                    nodeWidgets: filteredProjects
                        .map((p) => ProjectTile(node: p))
                        .toList()),
              ].expand((x) => x).toList(),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> section({
    required BuildContext context,
    required String sectionTitle,
    required List<Widget> nodeWidgets,
    double widgetExtentMultple = 16,
  }) {
    return <Widget>[
      SliverToBoxAdapter(
        child: Text(
          sectionTitle,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(decoration: TextDecoration.underline),
        ),
      ),
      SliverGrid.extent(
        maxCrossAxisExtent: Theme.of(context).textTheme.titleLarge!.fontSize! *
            widgetExtentMultple,
        childAspectRatio: 3.5,
        children: nodeWidgets,
      ),
    ];
  }
}
