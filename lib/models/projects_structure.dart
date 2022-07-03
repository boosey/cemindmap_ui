import 'dart:developer';

import 'package:cemindmap_ui/models/project.dart';
import 'package:flutter/material.dart';

class BasicNode {
  final String id;
  final bool isProject;
  int spaceMultiplier;
  Size _size = const Size(0, 0);
  bool isSizeDirty = false;

  Size get size {
    isSizeDirty = false;
    return _size;
  }

  set size(Size s) {
    isSizeDirty = true;
    _size = s;
  }

  BasicNode(
      {this.id = "n/a", this.isProject = false, this.spaceMultiplier = 0});

  int getSpaceMultiplier() {
    return spaceMultiplier;
  }
}

class ProjectNode extends BasicNode {
  final Project project;

  ProjectNode({required this.project, super.spaceMultiplier = 2})
      : super(id: project.projectId!, isProject: true);

  @override
  int getSpaceMultiplier() => spaceMultiplier;
}

class LabelNode<T> extends BasicNode {
  final String label;
  LabelNode({required this.label});

  final Map<String, BasicNode> children = {};

  void addChild(BasicNode node) {
    children.putIfAbsent(label, () => node);
  }

  @override
  int getSpaceMultiplier() {
    if (spaceMultiplier <= 0) {
      spaceMultiplier = children.values.map((e) {
        log(e.getSpaceMultiplier().toString());
        return e.getSpaceMultiplier();
      }).reduce((total, count) => total += count);
    }
    return spaceMultiplier;
  }
}

class AccountNode extends LabelNode<Project> {
  AccountNode({required super.label});
}

class SquadNode extends LabelNode<AccountNode> {
  SquadNode({required super.label});
}

class MarketNode extends LabelNode<SquadNode> {
  MarketNode({required super.label});
}

class GeoNode extends LabelNode<MarketNode> {
  GeoNode({required super.label});
}

class RootNode extends LabelNode<GeoNode> {
  RootNode({required super.label});
}

class ProjectStructure {
  final root = RootNode(label: "Client Engineering");

  ProjectStructure(List<Project> projects) {
    var i = 0;
    for (var p in projects) {
      addProject(p);
      if (i++ > 80) {
        break;
      }
    }
  }

  void addProject(Project p) {
    var geo = root.children.putIfAbsent(p.geo!, () => GeoNode(label: p.geo!))
        as GeoNode;
    var market =
        geo.children.putIfAbsent(p.market!, () => MarketNode(label: p.market!))
            as MarketNode;
    var squad = market.children.putIfAbsent(
            p.geoMarketSquad!, () => SquadNode(label: p.geoMarketSquad!))
        as SquadNode;
    var account = squad.children.putIfAbsent(
        p.accountId!, () => AccountNode(label: p.accountName!)) as AccountNode;
    account.children.putIfAbsent(p.projectId!, () => ProjectNode(project: p));
  }
}
