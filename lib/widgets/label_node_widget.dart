import 'package:cemindmap_ui/models/projects_structure.dart';
import 'package:cemindmap_ui/widgets/node_widget.dart';
import 'package:flutter/material.dart';

class LabelNodeWidget extends NodeWidget {
  const LabelNodeWidget({
    Key? key,
    required super.nodeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var labelNode = nodeData as LabelNode;
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.blue, spreadRadius: 1),
          ],
        ),
        child: Center(
            child: Column(
          children: [
            Text(labelNode.label),
            Text('(${"1"},${labelNode.getSpaceMultiplier()})'),
          ],
        )));
  }
}
