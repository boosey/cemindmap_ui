import 'package:cemindmap_ui/nodes/ww_node.dart';
import 'package:flutter/material.dart';

class WorldwideTile extends StatelessWidget {
  const WorldwideTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final WWNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.name),
      ),
    );
  }
}
