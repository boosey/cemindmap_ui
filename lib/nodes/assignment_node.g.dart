// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assignment_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssignmentNode _$AssignmentNodeFromJson(Map<String, dynamic> json) =>
    AssignmentNode()
      ..name = json['name'] as String
      ..talentNode =
          TalentNode.fromJson(json['talentNode'] as Map<String, dynamic>)
      ..projectNode =
          ProjectNode.fromJson(json['projectNode'] as Map<String, dynamic>)
      ..rawAssignment =
          RawAssignment.fromJson(json['rawAssignment'] as Map<String, dynamic>);

Map<String, dynamic> _$AssignmentNodeToJson(AssignmentNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'talentNode': instance.talentNode.toJson(),
      'projectNode': instance.projectNode.toJson(),
      'rawAssignment': instance.rawAssignment.toJson(),
    };
