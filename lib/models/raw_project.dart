import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'raw_project.g.dart';

mixin ProjectAdapter on RemoteAdapter<RawProject> {
  @override
  // String get baseUrl => 'http://localhost:8888/';
  String get baseUrl => const String.fromEnvironment("PROJECTS_BASE_URL");
}

@JsonSerializable()
@CopyWith()
@DataRepository([ProjectAdapter], internalType: 'rawprojects')
class RawProject extends DataModel<RawProject> {
  RawProject({
    this.id,
    this.projectId,
    this.projectName,
    this.opportunityId,
    this.accountId,
    this.accountName,
    this.notes,
    this.projectStage,
    this.startDate,
    this.endDate,
    this.projectLeaderId,
    this.projectLeaderName,
    this.opportunityOwnerId,
    this.opportunityOwnerName,
    this.marketCode,
    this.parentAccountCode,
    this.geo,
    this.geoMarketSquad,
    this.isExternalClientReference,
    this.market,
    this.opportunityName,
    this.amount,
    this.closeDate,
    this.isOpportunityClosed,
    this.isOpportunityWon,
    this.opportunityStage,
    this.opportunityFiscalPeriod,
    this.opportunityFiscalYear,
    this.createdAt,
  });

  final String? accountId;
  final String? accountName;
  final double? amount;
  final DateTime? closeDate;
  final DateTime? createdAt;
  final DateTime? endDate;
  final String? geo;
  final String? geoMarketSquad;
  final bool? isExternalClientReference;
  final bool? isOpportunityClosed;
  final bool? isOpportunityWon;
  final String? market;
  final String? marketCode;
  final String? notes;
  final String? opportunityFiscalPeriod;
  final String? opportunityFiscalYear;
  final String? opportunityId;
  final String? opportunityName;
  final String? opportunityOwnerId;
  final String? opportunityOwnerName;
  final String? opportunityStage;
  final String? parentAccountCode;
  final String? projectId;
  final String? projectLeaderId;
  final String? projectLeaderName;
  final String? projectName;
  final String? projectStage;
  final DateTime? startDate;

  @override
  final int? id;

  static RawProject fromJson(Map<String, dynamic> json) =>
      _$RawProjectFromJson(json);

  Map<String, dynamic> toJson() => _$RawProjectToJson(this);
}
