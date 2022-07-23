import 'package:cemindmap_ui/models/raw_assignment.dart';
import 'package:json_annotation/json_annotation.dart';
import 'node_data.dart';

part 'talent_node.g.dart';

@JsonSerializable(explicitToJson: true)
class TalentNode extends NodeData {
  TalentNode() : super(key: 'N/A', name: "N/A");

  TalentNode.fromRawAssignment({
    required RawAssignment rawAssignment,
  }) : super(
            key: rawAssignment.talentId ??
                "no name talent in assignment id ${rawAssignment.assignmentId}",
            name: rawAssignment.talentName ?? "N/A");

  factory TalentNode.fromJson(Map<String, dynamic> data) =>
      _$TalentNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$TalentNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is TalentNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
