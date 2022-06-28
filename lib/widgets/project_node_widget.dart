import 'package:cemindmap_ui/widgets/node_widget.dart';
import 'package:flutter/material.dart';

class ProjectNodeWidget extends NodeWidget {
  const ProjectNodeWidget({
    Key? key,
    required super.nodeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Text(nodeData.key));
  }
}
