import 'package:flutter/material.dart';

import '../nodes/account_node.dart';
import '../nodes/geo_node.dart';
import '../nodes/market_node.dart';
import '../nodes/project_node.dart';
import '../nodes/squad_node.dart';

class ProjectTile extends Tile {
  const ProjectTile({
    Key? key,
    required this.node,
    super.color,
  }) : super(key: key);

  final ProjectNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: ListTile(
        title: Text(node.rawProject.projectName!),
        subtitle: const Text('Project'),
      ),
    );
  }
}

class AccountTile extends Tile {
  const AccountTile({
    Key? key,
    required this.node,
    super.color,
  }) : super(key: key);

  final AccountNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Account'),
      ),
    );
  }
}

class SquadTile extends Tile {
  const SquadTile({
    Key? key,
    required this.node,
    super.color,
  }) : super(key: key);

  final SquadNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Squad'),
      ),
    );
  }
}

class MarketTile extends Tile {
  const MarketTile({
    Key? key,
    required this.node,
    super.color,
  }) : super(key: key);

  final MarketNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Market'),
      ),
    );
  }
}

class GeoTile extends Tile {
  const GeoTile({
    Key? key,
    required this.node,
    super.color,
  }) : super(key: key);

  final GeoNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      color: color,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Geo'),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final Color color;

  const Tile({
    Key? key,
    this.color = Colors.blueAccent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
