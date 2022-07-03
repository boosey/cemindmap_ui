abstract class NodeData {
  NodeData({
    required this.key,
    this.isRoot = false,
    this.isProject = false,
    this.isSelected = false,
    this.isAssignmentListExpanded = false,
  });

  final String key;
  final bool isRoot;
  final bool isProject;
  final bool isSelected;
  final bool isAssignmentListExpanded;

  @override
  // ignore: hash_and_equals
  int get hashCode => key.hashCode;
}
