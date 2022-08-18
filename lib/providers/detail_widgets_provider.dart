import 'package:flutter/material.dart';
import 'package:flutter_data/flutter_data.dart';

class DetailWidgetsNotifier extends StateNotifier<Map<String, Widget>> {
  DetailWidgetsNotifier(super.state);

  insertDetailWidget({required String name, required Widget? widget}) {
    if (widget != null) {
      state.putIfAbsent(name, () => widget);
      state = Map.of(state);
    }
  }

  updateDetailWidgetPosition({required String name, required Widget? widget}) {
    if (widget != null && name.isNotEmpty && state.containsKey(name)) {
      state.remove(name);
      state.putIfAbsent(name, () => widget);
      state = Map.of(state);
    }
  }

  removeDetailWidget({required String name}) {
    if (state.remove(name) != null) {
      state = Map.of(state);
    }
  }
}

final detailWidgetsProvider =
    StateNotifierProvider<DetailWidgetsNotifier, Map<String, Widget>>(
        (ref) => DetailWidgetsNotifier({}));
