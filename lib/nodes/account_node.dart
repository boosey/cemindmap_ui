import 'package:cemindmap_ui/nodes/squad_node.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/raw_project.dart';
import 'node_data.dart';

part 'account_node.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountNode extends NodeData {
  AccountNode() : super(key: 'na');

  AccountNode.fromRawProject({
    required RawProject rawProject,
    required this.squad,
  }) : super(
            key: rawProject.parentAccountCode ??
                "no parent account id in project id ${rawProject.projectId}") {
    accountName = rawProject.accountName!;
    accountId = rawProject.accountId!;
    parentAccountId = rawProject.parentAccountCode!;
  }

  late String accountId;
  late String accountName;
  late String parentAccountId;
  late SquadNode squad;

  factory AccountNode.fromJson(Map<String, dynamic> data) =>
      _$AccountNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$AccountNodeToJson(this);
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is AccountNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
