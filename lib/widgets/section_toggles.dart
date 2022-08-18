import 'package:cemindmap_ui/providers/view_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SectionTogglesWidget extends ConsumerWidget {
  const SectionTogglesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionFlags =
        ref.watch(viewSettingsProvider)[ViewSettings.showSectionsFlags]
            as List<bool>;

    return ToggleButtons(
        onPressed: (int index) {
          sectionFlags[index] = !sectionFlags[index];
          ref
              .read(viewSettingsProvider.notifier)
              .setViewSetting(ViewSettings.showSectionsFlags, sectionFlags);
        },
        isSelected: sectionFlags,
        children: const <Widget>[
          Icon(Icons.public),
          Icon(Icons.storefront),
          Icon(Icons.groups),
          Icon(Icons.account_balance),
          Icon(Icons.lightbulb),
          Icon(Icons.person),
        ]);
  }
}
