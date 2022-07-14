import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/providers/filtered_nodes_providers.dart';
import 'package:cemindmap_ui/providers/all_nodes_providers.dart';
import 'package:cemindmap_ui/providers/set_provider.dart';
import 'package:cemindmap_ui/widgets/filter_widget.dart';
import 'package:cemindmap_ui/widgets/tiles.dart';
import 'package:cemindmap_ui/widgets/view_by_widget.dart';
import 'package:cemindmap_ui/widgets/worldwide_tile.dart';
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
    final wwNode = ref.watch(worldwideNodeProvider);
    final filteredGeos = ref.watch(filteredGeosProvider);
    final filteredMarkets = ref.watch(filteredMarketsProvider);
    final filteredSquads = ref.watch(filteredSquadProvider);
    final filteredAccounts = ref.watch(filteredAccountsProvider);
    final filteredProjects = ref.watch(filteredProjectsProvider);

    if (filteredProjects.isEmpty) {
      return const CircularProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              ViewByWidget(),
              FilterWidget(
                label: "Geography",
                itemSetProvider: geoSetProvider,
                selectionProvider: geoSelectionProvider,
              ),
              FilterWidget(
                label: "Market",
                itemSetProvider: marketSetProvider,
                selectionProvider: marketSelectionProvider,
              ),
              FilterWidget(
                label: "Squad",
                itemSetProvider: squadSetProvider,
                selectionProvider: squadSelectionProvider,
              ),
              FilterWidget(
                label: "Account",
                itemSetProvider: accountSetProvider,
                selectionProvider: accountSelectionProvider,
              ),
            ],
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <List<Widget>>[
                section(
                    context: context,
                    sectionTitle: "Worldwide",
                    nodeWidgets: [
                      WorldwideTile(node: wwNode),
                    ]),
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
