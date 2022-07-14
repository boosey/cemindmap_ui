// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectNode _$ProjectNodeFromJson(Map<String, dynamic> json) => ProjectNode()
  ..rawProject = RawProject.fromJson(json['rawProject'] as Map<String, dynamic>)
  ..account = AccountNode.fromJson(json['account'] as Map<String, dynamic>);

Map<String, dynamic> _$ProjectNodeToJson(ProjectNode instance) =>
    <String, dynamic>{
      'rawProject': instance.rawProject.toJson(),
      'account': instance.account.toJson(),
    };
