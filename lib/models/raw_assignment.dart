import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'raw_assignment.g.dart';

mixin AssignmentAdapter on RemoteAdapter<RawAssignment> {
  @override
  // String get baseUrl => 'http://localhost:8888/';
  String get baseUrl => const String.fromEnvironment("ASSIGNMENTS_BASE_URL");
}

@JsonSerializable()
@CopyWith()
@DataRepository([AssignmentAdapter], internalType: 'rawassignments')
class RawAssignment extends DataModel<RawAssignment> {
  RawAssignment({
    this.id,
    this.assignmentId,
    this.assignmentName,
    this.talentId,
    this.talentName,
    this.projectId,
    this.projectName,
    this.startDate,
    this.endDate,
    this.milestone,
    this.scheduledDays,
    this.scheduledHours,
    this.createdAt,
  });

  final String? assignmentId;
  final String? assignmentName;
  final String? talentId;
  final String? talentName;
  final String? projectId;
  final String? projectName;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? milestone;
  final double? scheduledDays;
  final double? scheduledHours;
  final DateTime? createdAt;

  @override
  final int? id;

  static RawAssignment fromJson(Map<String, dynamic> json) =>
      _$RawAssignmentFromJson(json);

  Map<String, dynamic> toJson() => _$RawAssignmentToJson(this);
}
