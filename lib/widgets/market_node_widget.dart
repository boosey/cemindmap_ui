import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:flutter/material.dart';

class MarketNodeWidget extends LabelNodeWidget {
  const MarketNodeWidget({super.key, required super.nodeData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 73, 85, 245),
      child: LabelNodeWidget(nodeData: nodeData),
    );
  }
}
