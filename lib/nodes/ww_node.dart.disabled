import 'package:json_annotation/json_annotation.dart';

import 'node_data.dart';

part 'ww_node.g.dart';

@JsonSerializable()
class WWNode extends NodeData {
  WWNode({
    required super.key,
    this.name = "Client Engineering Worldwide",
  });

  final String name;

  factory WWNode.fromJson(Map<String, dynamic> data) => _$WWNodeFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$WWNodeToJson(this);

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is WWNode && other.runtimeType == runtimeType && other.key == key;
}
