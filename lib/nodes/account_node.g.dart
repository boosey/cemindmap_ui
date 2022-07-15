// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountNode _$AccountNodeFromJson(Map<String, dynamic> json) => AccountNode()
  ..name = json['name'] as String
  ..accountId = json['accountId'] as String
  ..parentAccountId = json['parentAccountId'] as String
  ..squadNode = SquadNode.fromJson(json['squadNode'] as Map<String, dynamic>);

Map<String, dynamic> _$AccountNodeToJson(AccountNode instance) =>
    <String, dynamic>{
      'name': instance.name,
      'accountId': instance.accountId,
      'parentAccountId': instance.parentAccountId,
      'squadNode': instance.squadNode.toJson(),
    };
