import 'package:cemindmap_ui/nodes/market_node.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/raw_project.dart';
import 'node_data.dart';

part 'squad_node.g.dart';

@JsonSerializable(explicitToJson: true)
class SquadNode extends NodeData {
  SquadNode() : super(key: 'N/A', name: "N/A");

  SquadNode.fromRawProject({
    required RawProject rawProject,
    required this.marketNode,
  }) : super(
            key: rawProject.geoMarketSquad ??
                "no name squad in project id ${rawProject.projectId}",
            name: rawProject.geoMarketSquad ?? "N/A");

  late MarketNode marketNode;

  factory SquadNode.fromJson(Map<String, dynamic> data) =>
      _$SquadNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$SquadNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is SquadNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
