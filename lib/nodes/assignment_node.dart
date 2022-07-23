import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/nodes/talent_node.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/raw_assignment.dart';
import 'node_data.dart';

part 'assignment_node.g.dart';

@JsonSerializable(explicitToJson: true)
class AssignmentNode extends NodeData {
  AssignmentNode() : super(key: 'N/A', name: "N/A");
  AssignmentNode.fromRawAssignment({
    required this.rawAssignment,
    required this.projectNode,
    required this.talentNode,
  }) : super(
            key: rawAssignment.assignmentId!,
            name: rawAssignment.assignmentName ?? "N/A");

  late TalentNode talentNode;
  late ProjectNode projectNode;
  late RawAssignment rawAssignment;

  factory AssignmentNode.fromJson(Map<String, dynamic> data) =>
      _$AssignmentNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$AssignmentNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is AssignmentNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
