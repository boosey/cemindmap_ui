import 'package:cemindmap_ui/widgets/node_widget.dart';
import 'package:flutter/material.dart';

class LabelNodeWidget extends NodeWidget {
  const LabelNodeWidget({
    Key? key,
    required super.nodeData,
  }) : super(key: key);

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
