import 'package:flutter/material.dart';

import '../nodes/account_node.dart';
import '../nodes/geo_node.dart';
import '../nodes/market_node.dart';
import '../nodes/project_node.dart';
import '../nodes/squad_node.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final ProjectNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.rawProject.projectName!),
        subtitle: const Text('Project'),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final AccountNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreen,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Account'),
      ),
    );
  }
}

class SquadTile extends StatelessWidget {
  const SquadTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final SquadNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 155, 63, 198),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Squad'),
      ),
    );
  }
}

class MarketTile extends StatelessWidget {
  const MarketTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final MarketNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.deepPurple,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Market'),
      ),
    );
  }
}

class GeoTile extends StatelessWidget {
  const GeoTile({
    Key? key,
    required this.node,
  }) : super(key: key);

  final GeoNode node;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        title: Text(node.name),
        subtitle: const Text('Geo'),
      ),
    );
  }
}
