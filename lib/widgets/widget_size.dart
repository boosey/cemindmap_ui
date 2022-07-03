import 'dart:developer';
import 'package:flutter/material.dart';

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    required super.key,
    required this.onChange,
    required this.child,
  }) : super();

  @override
  WidgetSizeState createState() => WidgetSizeState();
}

class WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  GlobalKey widgetKey = GlobalKey();
  Size? oldSize;

  void postFrameCallback(dynamic cbParam) {
    var context = widgetKey.currentContext;
    log("Context $context");
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    log("Key: $widgetKey");
    log("Size: old: $oldSize / new: $newSize");
    log("${cbParam.runtimeType}");

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
