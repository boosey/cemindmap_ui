import '../models/project.dart';
import 'node_data.dart';

class AccountNode extends NodeData {
  AccountNode({
    required super.key,
    required Project project,
  }) {
    accountName = project.accountName!;
    accountId = project.accountId!;
  }

  late String accountId;
  late String accountName;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      other is AccountNode &&
      other.runtimeType == runtimeType &&
      other.key == key;
}
