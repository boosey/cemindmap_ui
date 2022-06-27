import 'package:cemindmap_ui/models/project.dart';

class ProjectNodeData {
  ProjectNodeData({
    this.isRoot = false,
    this.isSelected = false,
    required this.project,
    this.isAssignmentListExpanded = false,
  });

  final bool isRoot;
  final bool isSelected;
  final bool isAssignmentListExpanded;
  final Project project;
}
