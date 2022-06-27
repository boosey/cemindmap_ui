// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// RepositoryGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, duplicate_ignore

mixin $ProjectLocalAdapter on LocalAdapter<Project> {
  static final Map<String, RelationshipMeta> _kProjectRelationshipMetas = {};

  @override
  Map<String, RelationshipMeta> get relationshipMetas =>
      _kProjectRelationshipMetas;

  @override
  Project deserialize(map) {
    map = transformDeserialize(map);
    return _$ProjectFromJson(map);
  }

  @override
  Map<String, dynamic> serialize(model, {bool withRelationships = true}) {
    final map = _$ProjectToJson(model);
    return transformSerialize(map, withRelationships: withRelationships);
  }
}

final _projectsFinders = <String, dynamic>{};

// ignore: must_be_immutable
class $ProjectHiveLocalAdapter = HiveLocalAdapter<Project>
    with $ProjectLocalAdapter;

class $ProjectRemoteAdapter = RemoteAdapter<Project> with ProjectAdapter;

final internalProjectsRemoteAdapterProvider = Provider<RemoteAdapter<Project>>(
    (ref) => $ProjectRemoteAdapter(
        $ProjectHiveLocalAdapter(ref.read), InternalHolder(_projectsFinders)));

final projectsRepositoryProvider =
    Provider<Repository<Project>>((ref) => Repository<Project>(ref.read));

extension ProjectDataRepositoryX on Repository<Project> {
  ProjectAdapter get projectAdapter => remoteAdapter as ProjectAdapter;
}

extension ProjectRelationshipGraphNodeX on RelationshipGraphNode<Project> {}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int?,
      projectId: json['projectId'] as String?,
      projectName: json['projectName'] as String?,
      opportunityId: json['opportunityId'] as String?,
      accountId: json['accountId'] as String?,
      accountName: json['accountName'] as String?,
      notes: json['notes'] as String?,
      projectStage: json['projectStage'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      projectLeaderId: json['projectLeaderId'] as String?,
      projectLeaderName: json['projectLeaderName'] as String?,
      opportunityOwnerId: json['opportunityOwnerId'] as String?,
      opportunityOwnerName: json['opportunityOwnerName'] as String?,
      marketCode: json['marketCode'] as String?,
      parentAccountCode: json['parentAccountCode'] as String?,
      geo: json['geo'] as String?,
      geoMarketSquad: json['geoMarketSquad'] as String?,
      isExternalClientReference: json['isExternalClientReference'] as bool?,
      market: json['market'] as String?,
      opportunityName: json['opportunityName'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      closeDate: json['closeDate'] == null
          ? null
          : DateTime.parse(json['closeDate'] as String),
      isOpportunityClosed: json['isOpportunityClosed'] as bool?,
      isOpportunityWon: json['isOpportunityWon'] as bool?,
      opportunityStage: json['opportunityStage'] as String?,
      opportunityFiscalPeriod: json['opportunityFiscalPeriod'] as String?,
      opportunityFiscalYear: json['opportunityFiscalYear'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'projectId': instance.projectId,
      'projectName': instance.projectName,
      'opportunityId': instance.opportunityId,
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'notes': instance.notes,
      'projectStage': instance.projectStage,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'projectLeaderId': instance.projectLeaderId,
      'projectLeaderName': instance.projectLeaderName,
      'opportunityOwnerId': instance.opportunityOwnerId,
      'opportunityOwnerName': instance.opportunityOwnerName,
      'marketCode': instance.marketCode,
      'parentAccountCode': instance.parentAccountCode,
      'geo': instance.geo,
      'geoMarketSquad': instance.geoMarketSquad,
      'isExternalClientReference': instance.isExternalClientReference,
      'market': instance.market,
      'opportunityName': instance.opportunityName,
      'amount': instance.amount,
      'closeDate': instance.closeDate?.toIso8601String(),
      'isOpportunityClosed': instance.isOpportunityClosed,
      'isOpportunityWon': instance.isOpportunityWon,
      'opportunityStage': instance.opportunityStage,
      'opportunityFiscalPeriod': instance.opportunityFiscalPeriod,
      'opportunityFiscalYear': instance.opportunityFiscalYear,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
