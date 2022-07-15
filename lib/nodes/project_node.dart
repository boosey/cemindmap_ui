import 'package:cemindmap_ui/models/raw_project.dart';
import 'package:cemindmap_ui/nodes/account_node.dart';
import 'package:json_annotation/json_annotation.dart';

import 'node_data.dart';

part 'project_node.g.dart';

@JsonSerializable(explicitToJson: true)
class ProjectNode extends NodeData {
  ProjectNode() : super(key: 'N/A', name: "N/A");
  ProjectNode.fromRawProject({
    required this.rawProject,
    required this.account,
    super.isProject = true,
  }) : super(key: rawProject.projectId!, name: rawProject.projectName ?? "N/A");

  late RawProject rawProject;
  late AccountNode account;

  factory ProjectNode.fromJson(Map<String, dynamic> data) =>
      _$ProjectNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$ProjectNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is ProjectNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
