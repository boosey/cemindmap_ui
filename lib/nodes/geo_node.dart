import '../models/project.dart';
import 'node_data.dart';

class GeoNode extends NodeData {
  GeoNode({
    required super.key,
    required Project project,
  }) {
    geoName = project.geo!;
  }

  late String geoName;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is GeoNode && other.runtimeType == runtimeType && other.key == key;
}
