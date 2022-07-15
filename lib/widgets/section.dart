import 'dart:math';

import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends HookConsumerWidget {
  final String sectionTitle;
  final double widgetExtentMultiple;
  final StateProvider<int> nodeDisplayCountProvider;
  final Widget Function(NodeData) delegate;
  final Provider<Set<NodeData>> filteredNodesProvider;

  const Section({
    Key? key,
    required this.sectionTitle,
    required this.filteredNodesProvider,
    required this.delegate,
    required this.nodeDisplayCountProvider,
    this.widgetExtentMultiple = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodeCount = ref.watch(nodeDisplayCountProvider);
    final filteredNodes = ref.watch(filteredNodesProvider);

    final tiles =
        filteredNodes.take(nodeCount).map((e) => delegate(e)).toList();

    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 25, 0, 8),
            child: Row(
              children: [
                Text(
                  sectionTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(decoration: TextDecoration.underline),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text("(${filteredNodes.length})"),
                ),
              ],
            ),
          ),
        ),
        SliverGrid.extent(
          maxCrossAxisExtent:
              Theme.of(context).textTheme.titleLarge!.fontSize! *
                  widgetExtentMultiple,
          childAspectRatio: 3.5,
          children: tiles,
        ),
        Visibility(
          visible: nodeCount < filteredNodes.length,
          child: SliverToBoxAdapter(
            child: Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: MaterialButton(
                  onPressed: () {
                    ref.read(nodeDisplayCountProvider.notifier).state =
                        min(filteredNodes.length, nodeCount + 25);
                  },
                  child: const Text(
                    "More",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
