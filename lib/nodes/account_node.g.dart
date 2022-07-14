// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountNode _$AccountNodeFromJson(Map<String, dynamic> json) => AccountNode()
  ..accountId = json['accountId'] as String
  ..accountName = json['accountName'] as String
  ..parentAccountId = json['parentAccountId'] as String
  ..squad = SquadNode.fromJson(json['squad'] as Map<String, dynamic>);

Map<String, dynamic> _$AccountNodeToJson(AccountNode instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'parentAccountId': instance.parentAccountId,
      'squad': instance.squad.toJson(),
    };
