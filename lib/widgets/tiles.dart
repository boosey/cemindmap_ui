import 'package:cemindmap_ui/nodes/node_data.dart';
import 'package:cemindmap_ui/nodes/project_node.dart';
import 'package:cemindmap_ui/providers/detail_widgets_provider.dart';
import 'package:cemindmap_ui/widgets/project_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class Tile extends ConsumerStatefulWidget {
  final Color color;
  final Color textColor;
  final NodeData node;

  const Tile({
    Key? key,
    required this.node,
    required this.color,
    required this.textColor,
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
      onHover: (event) {
        // RenderBox renderBox = context.findAncestorRenderObjectOfType() .findRenderObject() as RenderBox;
        position = Offset(event.position.dx - 10, event.position.dy - 150);
      },
      child: GestureDetector(
        // onTapDown: (details) => position = details.globalPosition,
        onDoubleTap: () {
          final hsl = HSLColor.fromColor(widget.color);
          final h = (hsl.hue * 180) % 360;
          final complementaryColor =
              HSLColor.fromAHSL(1, h, hsl.saturation, hsl.lightness).toColor();

          ref.read(detailWidgetsProvider.notifier).insertDetailWidget(
                name: widget.node.name,
                widget: DetailDialog(
                  position: position,
                  complementaryColor: complementaryColor,
                  ref: ref,
                  nodeName: widget.node.name,
                  detailWidget: widget.buildDetailWidget,
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

class DetailDialog extends StatelessWidget {
  const DetailDialog({
    Key? key,
    required this.position,
    required this.complementaryColor,
    required this.ref,
    required this.nodeName,
    required this.detailWidget,
  }) : super(key: key);

  final Offset position;
  final Color complementaryColor;
  final WidgetRef ref;
  final String nodeName;
  final Widget Function(BuildContext) detailWidget;

  @override
  Widget build(BuildContext context) {
    final detailContent = DetailView(
      ref: ref,
      nodeName: nodeName,
      detailWidget: detailWidget,
    );

    var detailDialog = Card(
      color: complementaryColor,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: detailContent,
    );
    return Positioned(
      top: position.dy,
      left: position.dx,
      child: Draggable(
        feedback: detailDialog,
        childWhenDragging: Container(),
        onDragEnd: (details) {
          RenderBox renderBox = context.findRenderObject() as RenderBox;
          ref.read(detailWidgetsProvider.notifier).updateDetailWidgetPosition(
                name: nodeName,
                widget: DetailDialog(
                  position: position + renderBox.globalToLocal(details.offset),
                  complementaryColor: complementaryColor,
                  ref: ref,
                  nodeName: nodeName,
                  detailWidget: detailWidget,
                ),
              );
        },
        child: detailDialog,
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView({
    Key? key,
    required this.ref,
    required this.nodeName,
    required this.detailWidget,
  }) : super(key: key);

  final WidgetRef ref;
  final String nodeName;
  final Widget Function(BuildContext) detailWidget;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => ref
              .read(detailWidgetsProvider.notifier)
              .removeDetailWidget(name: nodeName),
          icon: const Icon(Icons.cancel),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: detailWidget(context),
        ),
      ],
    );
  }
}

class ProjectTile extends Tile {
  const ProjectTile({
    Key? key,
    required super.node,
    required super.color,
    required super.textColor,
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
    required super.color,
    required super.textColor,
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
    required super.color,
    required super.textColor,
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
    required super.color,
    required super.textColor,
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
    required super.color,
    required super.textColor,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Geo'),
    );
  }
}

class AssignmentTile extends Tile {
  const AssignmentTile({
    Key? key,
    required super.node,
    required super.color,
    required super.textColor,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Assigment'),
    );
  }
}

class TalentTile extends Tile {
  const TalentTile({
    Key? key,
    required super.node,
    required super.color,
    required super.textColor,
  }) : super(key: key);

  @override
  Widget buildContent(BuildContext context) {
    return ListTile(
      title: Text(node.name),
      subtitle: const Text('Talent'),
    );
  }
}
