// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentNode _$AssignmentNodeFromJson(Map<String, dynamic> json) =>
    AssignmentNode()
      ..name = json['name'] as String
      ..rawAssignment =
          RawAssignment.fromJson(json['rawAssignment'] as Map<String, dynamic>);

Map<String, dynamic> _$AssignmentNodeToJson(AssignmentNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rawAssignment': instance.rawAssignment.toJson(),
    };
