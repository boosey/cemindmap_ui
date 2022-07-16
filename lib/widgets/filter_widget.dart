import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterWidget extends ConsumerWidget {
  const FilterWidget({
    Key? key,
    required this.items,
    required this.selected,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  final Set<String> items;
  final String label;
  final Function(String) onChanged;
  final String selected;

  List<DropdownMenuItem<String>> createDropdownItems(Set<String> items) {
    final dropdownItems = <DropdownMenuItem<String>>[];

    for (var i in items) {
      dropdownItems.add(DropdownMenuItem(value: i, child: Text(i)));
    }

    return dropdownItems;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dropdownItems = createDropdownItems(items);

    return Row(
      children: [
        const Padding(padding: EdgeInsets.all(10)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              textAlign: TextAlign.left,
            ),
            DropdownButton<String>(
              items: dropdownItems,
              value: selected,
              // When the user interacts with the dropdown, we update the provider state.
              onChanged: (value) => onChanged(value!),
            ),
          ],
        ),
      ],
    );
  }
}
