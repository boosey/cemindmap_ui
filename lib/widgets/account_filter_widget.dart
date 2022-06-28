import 'package:cemindmap_ui/providers/account_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountFilterWidget extends ConsumerWidget {
  const AccountFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var accounts = ref.watch(accountSetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filter By Geo",
          textAlign: TextAlign.left,
        ),
        DropdownButton<String>(
          items: items(accounts),
          value: accounts.first,
          onChanged: (value) {},
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> items(Set<String> accounts) {
    final dropdownItems = <DropdownMenuItem<String>>[];

    for (var a in accounts) {
      dropdownItems.add(DropdownMenuItem(value: a, child: Text(a)));
    }

    return dropdownItems;
  }
}
