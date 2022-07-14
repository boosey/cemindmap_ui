// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_node.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoNode _$GeoNodeFromJson(Map<String, dynamic> json) => GeoNode()
  ..name = json['name'] as String
  ..worldwideNode =
      WWNode.fromJson(json['worldwideNode'] as Map<String, dynamic>);

Map<String, dynamic> _$GeoNodeToJson(GeoNode instance) => <String, dynamic>{
      'name': instance.name,
      'worldwideNode': instance.worldwideNode.toJson(),
    };
