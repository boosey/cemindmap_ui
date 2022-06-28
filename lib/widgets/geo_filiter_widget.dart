import 'package:cemindmap_ui/providers/geo_set_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeoFilterWidget extends ConsumerWidget {
  const GeoFilterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var geos = ref.watch(geoSetProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Filter By Geo",
          textAlign: TextAlign.left,
        ),
        DropdownButton<String>(
          items: items(geos),
          value: geos.first,
          // When the user interacts with the dropdown, we update the provider state.
          onChanged: (value) {},
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> items(Set<String> geos) {
    final dropdownItems = <DropdownMenuItem<String>>[];

    for (var g in geos) {
      dropdownItems.add(DropdownMenuItem(value: g, child: Text(g)));
    }

    return dropdownItems;
  }
}
