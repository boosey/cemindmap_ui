abstract class NodeData {
  NodeData({
    required this.key,
    required this.name,
    this.isRoot = false,
    this.isProject = false,
    this.isSelected = false,
    this.isAssignmentListExpanded = false,
  });

  final String key;
  late String name;
  final bool isRoot;
  final bool isProject;
  final bool isSelected;
  final bool isAssignmentListExpanded;

  bool search(String term) {
    if (term.length >= 3) {
      final String searchable = convertValuesToSearchable(toJson());
      return searchable.contains(term.toUpperCase());
    }
    return true;
  }

  String convertValuesToSearchable(Map<String, dynamic> json) {
    return json.values.fold<String>('', (previousValue, element) {
      final additionalString = element is Map<String, dynamic>
          ? convertValuesToSearchable(element)
          : element.toString().toUpperCase();
      return previousValue + additionalString;
    });
  }

  Map<String, dynamic> toJson() {
    return {};
  }

  @override
  // ignore: hash_and_equals
  int get hashCode => key.hashCode;
}
