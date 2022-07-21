import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/providers/detail_widgets_provider.dart';
import 'package:cemindmap_ui/widgets/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Tile extends ConsumerStatefulWidget {
  final Color color;
  final NodeData node;

  const Tile({
    Key? key,
    required this.node,
    this.color = Colors.blueAccent,
  }) : super(key: key);

  Widget buildContent(BuildContext context);
  Widget buildDetailWidget(BuildContext context) {
    return Text("Not a Project ${node.name}");
  }

  @override
  TileState createState() {
    return TileState();
  }
}

class TileState extends ConsumerState<Tile> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    position = Offset.zero;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) =>
          position = Offset(event.position.dx, event.position.dy - 150),
      child: GestureDetector(
        onDoubleTap: () {
          final hsl = HSLColor.fromColor(widget.color);
          final h = (hsl.hue * 180) % 360;
          final complementaryColor =
              HSLColor.fromAHSL(1, h, hsl.saturation, hsl.lightness).toColor();

          ref.read(detailWidgetsProvider.notifier).insertDetailWidget(
                name: widget.node.name,
                widget: Positioned(
                  top: position.dy,
                  left: position.dx,
                  child: Card(
                    color: complementaryColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => ref
                              .read(detailWidgetsProvider.notifier)
                              .removeDetailWidget(name: widget.node.name),
                          icon: const Icon(Icons.cancel),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: widget.buildDetailWidget(context),
                        ),
                      ],
                    ),
                  ),
                ),
              );
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          color: widget.color,
          elevation: 10,
          shadowColor: Color((1 / widget.color.value).truncate()),
          margin: const EdgeInsets.all(10),
          child: widget.buildContent(context),
        ),
      ),
    );
  }
}

class ProjectTile extends Tile {
  const ProjectTile({
    Key? key,
    required super.node,
    super.color,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text((node as ProjectNode).rawProject.projectName!),
      subtitle: const Text('Project'),
      onTap: () {},
    );
  }

  @override
  Widget buildDetailWidget(BuildContext context) {
    return ProjectDetails(project: node as ProjectNode);
  }
}

class AccountTile extends Tile {
  const AccountTile({
    Key? key,
    required super.node,
    super.color,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Account'),
    );
  }
}

class SquadTile extends Tile {
  const SquadTile({
    Key? key,
    required super.node,
    super.color,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Squad'),
    );
  }
}

class MarketTile extends Tile {
  const MarketTile({
    Key? key,
    required super.node,
    super.color,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Market'),
    );
  }
}

class GeoTile extends Tile {
  const GeoTile({
    Key? key,
    required super.node,
    super.color,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Geo'),
    );
  }
}
