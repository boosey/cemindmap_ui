import '../models/project.dart';
import 'node_data.dart';

class MarketNode extends NodeData {
  MarketNode({
    required super.key,
    required Project project,
  }) {
    marketName = project.market!;
  }

  late String marketName;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is MarketNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
