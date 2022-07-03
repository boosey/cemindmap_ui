import '../models/project.dart';
import 'node_data.dart';

class SquadNode extends NodeData {
  SquadNode({
    required super.key,
    required Project project,
  }) {
    squadName = project.market!;
  }

  late String squadName;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is SquadNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
