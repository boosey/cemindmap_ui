import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProjectDetails extends ConsumerWidget {
  const ProjectDetails(
      {this.color = Colors.blueAccent, required this.project, Key? key})
      : super(key: key);

  final Color color;
  final ProjectNode project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          direction: Axis.vertical,
          spacing: 8,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "Project",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
            Text(project.name,
                style: Theme.of(context).textTheme.headlineSmall!),
            Text("Leader: ${project.rawProject.projectLeaderName}"),
            Text("Account: ${project.rawProject.accountName}"),
            Text("Start Date: ${project.rawProject.startDate}"),
            Text("End Date: ${project.rawProject.endDate}"),
            Text("Squad: ${project.rawProject.geoMarketSquad}"),
            Text("Market: ${project.rawProject.market}"),
            Text("Project Stage: ${project.rawProject.projectStage}"),
          ],
        ),
      ],
    );

    return details;
  }
}
