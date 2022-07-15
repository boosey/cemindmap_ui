import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';

class Section extends HookConsumerWidget {
  final String sectionTitle;
  final List<Widget> nodeWidgets;
  final double widgetExtentMultple;

  final StateProvider<int>? nodeDisplayCountProvider;

  const Section({
    Key? key,
    required this.sectionTitle,
    required this.nodeWidgets,
    required this.nodeDisplayCountProvider,
    this.widgetExtentMultple = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: Text("(${nodeWidgets.length})"),
                ),
              ],
            ),
          ),
        ),
        SliverGrid.extent(
          maxCrossAxisExtent:
              Theme.of(context).textTheme.titleLarge!.fontSize! *
                  widgetExtentMultple,
          childAspectRatio: 3.5,
          children: nodeWidgets.take(50).toList(),
        ),
        const SliverToBoxAdapter(
          child: Card(
            color: Colors.blueAccent,
            child: Padding(
              padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
              child: Text(
                "More",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
