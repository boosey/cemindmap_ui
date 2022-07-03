import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:flutter/material.dart';

class GeoNodeWidget extends LabelNodeWidget {
  const GeoNodeWidget({super.key, required super.nodeData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 245, 209, 101),
      child: LabelNodeWidget(nodeData: nodeData),
    );
  }
}
