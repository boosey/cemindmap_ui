import 'package:cemindmap_ui/node_data.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({
    Key? key,
    required this.nodeData,
  }) : super(key: key);

  final NodeData nodeData;

  @override
  Widget build(BuildContext context) {
    String title = nodeData.isRoot ? "Client Engineering" : nodeData.key;

    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Text(title));
  }
}
