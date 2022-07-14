// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketNode _$MarketNodeFromJson(Map<String, dynamic> json) => MarketNode()
  ..marketName = json['marketName'] as String
  ..geoNode = GeoNode.fromJson(json['geoNode'] as Map<String, dynamic>);

Map<String, dynamic> _$MarketNodeToJson(MarketNode instance) =>
    <String, dynamic>{
      'marketName': instance.marketName,
      'geoNode': instance.geoNode.toJson(),
    };
