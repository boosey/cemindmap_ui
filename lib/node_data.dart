import 'package:cemindmap_ui/models/project.dart';

class NodeData {
  NodeData({
    required this.key,
    this.isRoot = false,
    this.isProject = false,
    this.isSelected = false,
    this.project,
    this.isAssignmentListExpanded = false,
  });

  final String key;
  final bool isRoot;
  final bool isProject;
  final bool isSelected;
  final bool isAssignmentListExpanded;
  late Project? project;

  @override
  bool operator ==(Object other) =>
      other is NodeData && other.runtimeType == runtimeType && other.key == key;

  @override
  int get hashCode => key.hashCode;
}
