import 'dart:math';

import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends HookConsumerWidget {
  const Section({
    Key? key,
    required this.sectionTitle,
    required this.filteredNodesProvider,
    required this.delegate,
    required this.nodeDisplayCountProvider,
    this.moreButtonColor = Colors.blueAccent,
    this.widgetExtentMultiple = 16,
  }) : super(key: key);

  final Widget Function(NodeData) delegate;
  final Provider<Set<NodeData>> filteredNodesProvider;
  final StateProvider<int> nodeDisplayCountProvider;
  final String sectionTitle;
  final double widgetExtentMultiple;
  final Color moreButtonColor;

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
          visible: filteredNodes.isNotEmpty && nodeCount < filteredNodes.length,
          child: SliverToBoxAdapter(
            child: Card(
              color: moreButtonColor,
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
      ],
    );
  }
}
