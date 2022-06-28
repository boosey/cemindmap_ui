import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterWidget extends ConsumerWidget {
  final String label;
  final Provider<Set<String>> itemSetProvider;

  const FilterWidget({
    Key? key,
    required this.itemSetProvider,
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
          value: items.first,
          // When the user interacts with the dropdown, we update the provider state.
          onChanged: (value) {},
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
