import 'package:cemindmap_ui/models/project.dart';

import 'node_data.dart';

class ProjectNode extends NodeData {
  ProjectNode({
    required super.key,
    required this.project,
    super.isProject = true,
  });

  final Project? project;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is ProjectNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
