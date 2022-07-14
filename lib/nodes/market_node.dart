import 'package:cemindmap_ui/nodes/geo_node.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/raw_project.dart';
import 'node_data.dart';

part 'market_node.g.dart';

@JsonSerializable(explicitToJson: true)
class MarketNode extends NodeData {
  MarketNode() : super(key: 'na');

  MarketNode.fromRawProject({
    required RawProject rawProject,
    required this.geoNode,
  }) : super(
            key: rawProject.market ??
                "no name market in project id ${rawProject.projectId}") {
    marketName = rawProject.market!;
  }

  late String marketName;
  late GeoNode geoNode;

  factory MarketNode.fromJson(Map<String, dynamic> data) =>
      _$MarketNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$MarketNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is MarketNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
