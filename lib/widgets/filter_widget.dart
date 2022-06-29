import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/set_provider.dart';

class FilterWidget extends ConsumerWidget {
  final String label;
  final Provider<Set<String>> itemSetProvider;
  final StateNotifierProvider<FilterSelection, String> selectionProvider;

  const FilterWidget({
    Key? key,
    required this.itemSetProvider,
    required this.selectionProvider,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(itemSetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          textAlign: TextAlign.left,
        ),
        DropdownButton<String>(
          items: createDropdownItems(items),
          value: ref.read(selectionProvider).isNotEmpty
              ? ref.read(selectionProvider)
              : items.first,
          // When the user interacts with the dropdown, we update the provider state.
          onChanged: (value) {
            ref.read(selectionProvider.notifier).selection(value!);
          },
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> createDropdownItems(Set<String> items) {
    final dropdownItems = <DropdownMenuItem<String>>[];

    for (var g in items) {
      dropdownItems.add(DropdownMenuItem(value: g, child: Text(g)));
    }

    return dropdownItems;
  }
}
