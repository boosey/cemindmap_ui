import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ViewByChoice {
  organization,
  projectLeader,
  account,
}

class ViewBySelection extends StateNotifier<ViewByChoice> {
  ViewBySelection() : super(ViewByChoice.organization);

  selectView(ViewByChoice choice) {
    state = choice;
  }

  static Map<ViewByChoice, String> choices() => {
        ViewByChoice.organization: "Organization",
        ViewByChoice.account: "Account",
        ViewByChoice.projectLeader: "Project Leader",
      };
}

final viewBySelectionProvider =
    StateNotifierProvider<ViewBySelection, ViewByChoice>(
        (ref) => ViewBySelection());
