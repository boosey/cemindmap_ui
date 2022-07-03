import 'dart:developer';

import 'package:cemindmap_ui/main.data.dart';
import 'package:cemindmap_ui/models/projects_structure.dart';
import 'package:cemindmap_ui/providers/set_provider.dart';
import 'package:cemindmap_ui/widgets/filter_widget.dart';
import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:cemindmap_ui/widgets/project_node_widget.dart';
import 'package:cemindmap_ui/widgets/view_by_widget.dart';
import 'package:cemindmap_ui/widgets/widget_size.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'providers/project_structure_state_notifier.dart';

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
    final projectStructureProvider =
        StateNotifierProvider<ProjectStructureStateNotifier, ProjectStructure>(
            (r) {
      final projects = ref.projects.watchAll();
      // final viewBySelection = ref.watch(viewBySelectionProvider);
      // final geoSelection = ref.watch(geoSelectionProvider);
      // final marketSelection = ref.watch(marketSelectionProvider);
      // final squadSelection = ref.watch(squadSelectionProvider);
      // final accountSelection = ref.watch(accountSelectionProvider);
      return ProjectStructureStateNotifier(
        projects: projects.hasModel ? projects.model! : [],
        // geoSelection: geoSelection,
        // marketSelection: marketSelection,
        // squadSelection: squadSelection,
        // accountSelection: accountSelection,
        // viewBySelection: viewBySelection,
      );
    });

    var projectStructure = ref.watch(projectStructureProvider);

    Widget createLabelTile(LabelNode node) {
      return Card(
        color: Colors.blueGrey,
        child: LabelNodeWidget(nodeData: node),
      );
    }

    Card createProjectTile(ProjectNode node) {
      return Card(
        color: Colors.green,
        child: ProjectNodeWidget(nodeData: node),
      );
    }

    // Widget createProjectWidget(ProjectNode project) {
    //   return createProjectTile(project);
    // }

    // Widget createAccountWidget(LabelNode account) {
    //   return Flex(
    //     direction: Axis.horizontal,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       createLabelTile(account),
    //       Flex(
    //         direction: Axis.vertical,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: account.children.values
    //             .map((project) => createProjectWidget(project as ProjectNode))
    //             .toList(),
    //       ),
    //     ],
    //   );
    // }

    // Widget createSquadWidget(LabelNode squad) {
    //   return Flex(
    //     direction: Axis.horizontal,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       createLabelTile(squad),
    //       // Flex(
    //       //   direction: Axis.vertical,
    //       //   mainAxisAlignment: MainAxisAlignment.center,
    //       //   crossAxisAlignment: CrossAxisAlignment.center,
    //       //   children: squad.children.values
    //       //       .map((account) => createAccountWidget(account as LabelNode))
    //       //       .toList(),
    //       // ),
    //     ],
    //   );
    // }

    // Widget createMarketWidget(LabelNode market) {
    //   return Flex(
    //     direction: Axis.horizontal,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       createLabelTile(market),
    //       Column(
    //         // direction: Axis.vertical,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: market.children.values
    //             .map((squad) => createSquadWidget(squad as LabelNode))
    //             .toList(),
    //       ),
    //     ],
    //   );
    // }

    // Widget createGeoWidget(LabelNode geo) {
    //   return Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       createLabelTile(geo),
    //       Column(
    //         // direction: Axis.vertical,
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: geo.children.values
    //             .map((market) => createMarketWidget(market as LabelNode))
    //             .toList(),
    //       ),
    //     ],
    //   );
    // }

    // Widget createRootWidget(ProjectStructure projectStructure) {
    //   return Row(
    //     children: [
    //       createLabelTile(projectStructure.root),
    //       Column(
    //           // direction: Axis.vertical,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: projectStructure.root.children.values
    //               .map((geo) => createGeoWidget(geo as LabelNode))
    //               .toList()),
    //     ],
    //   );
    // }

    List<Widget> tiles = [];
    List<Card> projectWidgets = [];

    for (var geo in projectStructure.root.children.values) {
      tiles.add(
        createLabelTile(geo as GeoNode),
      );
      for (var market in geo.children.values) {
        tiles.add(
          createLabelTile(market as MarketNode),
        );
        for (var squad in market.children.values) {
          tiles.add(
            createLabelTile(squad as SquadNode),
          );
          for (var account in squad.children.values) {
            tiles.add(
              createLabelTile(account as AccountNode),
            );
            for (var project in account.children.values) {
              var p = createProjectTile(project as ProjectNode);
              tiles.add(p);
              projectWidgets.add(p);
            }
          }
        }
      }
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
          SingleChildScrollView(
            // child: createRootWidget(projectStructure),
            child: Column(
              children: [
                WidgetSize(
                    key: const Key("p1"),
                    onChange: (newSize) =>
                        log("p1 callBackCalled with: $newSize"),
                    child: projectWidgets[0]),
                WidgetSize(
                    key: const Key("p2"),
                    onChange: (newSize) =>
                        log("p2 callBackCalled with: $newSize"),
                    child: projectWidgets[1]),
                WidgetSize(
                    key: const Key("p3"),
                    onChange: (newSize) =>
                        log("p3 callBackCalled with: $newSize"),
                    child: projectWidgets[2]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
