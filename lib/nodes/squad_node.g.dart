// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'squad_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquadNode _$SquadNodeFromJson(Map<String, dynamic> json) => SquadNode()
  ..squadName = json['squadName'] as String
  ..marketNode =
      MarketNode.fromJson(json['marketNode'] as Map<String, dynamic>);

Map<String, dynamic> _$SquadNodeToJson(SquadNode instance) => <String, dynamic>{
      'squadName': instance.squadName,
      'marketNode': instance.marketNode.toJson(),
    };
