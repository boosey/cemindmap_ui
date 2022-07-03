import 'package:cemindmap_ui/widgets/label_node_widget.dart';
import 'package:flutter/material.dart';

class AccountNodeWidget extends LabelNodeWidget {
  const AccountNodeWidget({super.key, required super.nodeData});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 80, 144, 85),
      child: LabelNodeWidget(nodeData: nodeData),
    );
  }
}
