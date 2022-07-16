import 'package:cemindmap_ui/providers/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
        decoration: const InputDecoration(icon: Icon(Icons.search)),
        onChanged: (value) {
          ref.read(filterProvider.notifier).searchTerms = value;
        });
  }
}
