import 'dart:developer';

import 'package:cemindmap_ui/models/projects_structure.dart';
import 'package:cemindmap_ui/widgets/node_widget.dart';
import 'package:flutter/material.dart';

class ProjectNodeWidget extends NodeWidget {
  final GlobalKey widgetKey = GlobalKey();
  final List<Size> oldSize = const [];

  ProjectNodeWidget({
    Key? key,
    required super.nodeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(postFrameCallback);
    var projectNode = nodeData as ProjectNode;
    return Card(
      color: const Color.fromARGB(255, 104, 71, 106),
      child: Column(
        children: [
          Text(projectNode.project.projectName!),
          Text('(${"1"},${projectNode.getSpaceMultiplier()})'),
        ],
      ),
    );
  }

  void postFrameCallback(dynamic cbParam) {
    var context = widgetKey.currentContext;
    log("Context $context");
    if (context == null) return;

    Size newSize = context.size!;

    log("Key: $widgetKey");
    log("Size: old: ${oldSize[0]} / new: $newSize");
    log("${cbParam.runtimeType}");

    if (oldSize.isEmpty) {
      oldSize.add(newSize);
    } else if (oldSize[0] == newSize) {
      return;
    } else {
      oldSize.clear();
      oldSize.add(newSize);
    }

    nodeData.size = newSize;
  }
}
