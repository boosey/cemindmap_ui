import 'package:cemindmap_ui/widgets/filter_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/filter_provider.dart';

class FilterBar extends HookConsumerWidget {
  const FilterBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(filterProvider);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          FilterWidget(
            label: "Geography",
            items: filter.geoOptions,
            selected: filter.geoSelection,
            onChanged: (value) => ref
                .read<FilterNotifier>(filterProvider.notifier)
                .geoSelection = value,
          ),
          FilterWidget(
            label: "Market",
            items: filter.marketOptions,
            selected: filter.marketSelection,
            onChanged: (value) => ref
                .read<FilterNotifier>(filterProvider.notifier)
                .marketSelection = value,
          ),
          FilterWidget(
            label: "Squad",
            items: filter.squadOptions,
            selected: filter.squadSelection,
            onChanged: (value) => ref
                .read<FilterNotifier>(filterProvider.notifier)
                .squadSelection = value,
          ),
          FilterWidget(
            label: "Account",
            items: filter.accountOptions,
            selected: filter.accountSelection,
            onChanged: (value) => ref
                .read<FilterNotifier>(filterProvider.notifier)
                .accountSelection = value,
          ),
        ],
      ),
    );
  }
}
