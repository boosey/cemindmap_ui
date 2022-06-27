import 'package:flutter_data/flutter_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'project.g.dart';

mixin ProjectAdapter on RemoteAdapter<Project> {
  @override
  String get baseUrl => 'http://localhost:8888/';
}

@JsonSerializable()
@CopyWith()
@DataRepository([ProjectAdapter])
class Project extends DataModel<Project> {
  @override
  final int? id;
  final String? projectId;
  final String? projectName;
  final String? opportunityId;
  final String? accountId;
  final String? accountName;
  final String? notes;
  final String? projectStage;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? projectLeaderId;
  final String? projectLeaderName;
  final String? opportunityOwnerId;
  final String? opportunityOwnerName;
  final String? marketCode;
  final String? parentAccountCode;
  final String? geo;
  final String? geoMarketSquad;
  final bool? isExternalClientReference;
  final String? market;
  final String? opportunityName;
  final double? amount;
  final DateTime? closeDate;
  final bool? isOpportunityClosed;
  final bool? isOpportunityWon;
  final String? opportunityStage;
  final String? opportunityFiscalPeriod;
  final String? opportunityFiscalYear;

  final DateTime? createdAt;

  Project({
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
}
