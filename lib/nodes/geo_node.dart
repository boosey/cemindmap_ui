import 'package:cemindmap_ui/nodes/ww_node.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models/raw_project.dart';
import 'node_data.dart';

part 'geo_node.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoNode extends NodeData {
  GeoNode() : super(key: 'na');

  GeoNode.fromRawProject({
    required RawProject rawProject,
    required this.worldwideNode,
  }) : super(
            key: rawProject.geo ??
                "no name geo in project id ${rawProject.projectId}") {
    name = rawProject.geo!;
  }

  late String name;
  late WWNode worldwideNode;

  factory GeoNode.fromJson(Map<String, dynamic> data) =>
      _$GeoNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$GeoNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is GeoNode && other.runtimeType == runtimeType && other.key == key;
}
