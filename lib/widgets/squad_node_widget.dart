import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:flutter/material.dart';

class SquadNodeWidget extends LabelNodeWidget {
  const SquadNodeWidget({super.key, required super.nodeData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber,
      child: LabelNodeWidget(nodeData: nodeData),
    );
  }
}
