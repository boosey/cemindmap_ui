import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/view_by_selection.dart';

class ViewByWidget extends ConsumerWidget {
  ViewByWidget({
    Key? key,
  }) : super(key: key);

  final Map<ViewByChoice, DropdownMenuItem<ViewByChoice>> items =
      ViewBySelection.choices()
          .map<ViewByChoice, DropdownMenuItem<ViewByChoice>>(
              (choice, label) => MapEntry(
                    choice,
                    DropdownMenuItem(
                      value: choice,
                      child: Text(label),
                    ),
                  ));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "View By",
          textAlign: TextAlign.left,
        ),
        DropdownButton<ViewByChoice>(
          items: items.values.toList(),

          value: ref.watch(viewBySelectionProvider),
          // When the user interacts with the dropdown, we update the provider state.
          onChanged: (value) =>
              ref.read(viewBySelectionProvider.notifier).selectView(value!),
        ),
      ],
    );
  }
}
