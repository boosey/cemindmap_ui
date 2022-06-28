import 'package:cemindmap_ui/node_data.dart';
import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:cemindmap_ui/widgets/project_node_widget.dart';
import 'package:flutter/material.dart';

class NodeWidget extends StatelessWidget {
  const NodeWidget({
    Key? key,
    required this.nodeData,
  }) : super(key: key);

  final NodeData nodeData;

  factory NodeWidget.from({required NodeData nodeData}) {
    if (!nodeData.isProject) {
      return LabelNodeWidget(nodeData: nodeData);
    }

    if (nodeData.isProject) {
      return ProjectNodeWidget(nodeData: nodeData);
    }

    return NodeWidget(nodeData: nodeData);
  }

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
        child: Text("Superclass: $title"));
  }
}
