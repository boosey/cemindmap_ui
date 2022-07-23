

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: directives_ordering, top_level_function_literal_block

import 'package:flutter_data/flutter_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cemindmap_ui/models/raw_assignment.dart';
import 'package:cemindmap_ui/models/raw_project.dart';

// ignore: prefer_function_declarations_over_variables
ConfigureRepositoryLocalStorage configureRepositoryLocalStorage = ({FutureFn<String>? baseDirFn, List<int>? encryptionKey, bool? clear}) {
  if (!kIsWeb) {
    baseDirFn ??= () => getApplicationDocumentsDirectory().then((dir) => dir.path);
  } else {
    baseDirFn ??= () => '';
  }
  
  return hiveLocalStorageProvider
    .overrideWithProvider(Provider((ref) => HiveLocalStorage(
            hive: ref.read(hiveProvider),
            baseDirFn: baseDirFn,
            encryptionKey: encryptionKey,
            clear: clear,
          )));
};

final repositoryProviders = <String, Provider<Repository<DataModel>>>{
  'rawAssignments': rawAssignmentsRepositoryProvider,
'rawProjects': rawProjectsRepositoryProvider
};

final repositoryInitializerProvider =
  FutureProvider<RepositoryInitializer>((ref) async {
    final adapters = <String, RemoteAdapter>{'rawAssignments': ref.watch(internalRawAssignmentsRemoteAdapterProvider), 'rawProjects': ref.watch(internalRawProjectsRemoteAdapterProvider)};
    final remotes = <String, bool>{'rawAssignments': true, 'rawProjects': true};

    await ref.watch(graphNotifierProvider).initialize();

    // initialize and register
    for (final type in repositoryProviders.keys) {
      final repository = ref.read(repositoryProviders[type]!);
      repository.dispose();
      await repository.initialize(
        remote: remotes[type],
        adapters: adapters,
      );
      internalRepositories[type] = repository;
    }

    return RepositoryInitializer();
});
extension RepositoryWidgetRefX on WidgetRef {
  Repository<RawAssignment> get rawAssignments => watch(rawAssignmentsRepositoryProvider)..remoteAdapter.internalWatch = watch;
  Repository<RawProject> get rawProjects => watch(rawProjectsRepositoryProvider)..remoteAdapter.internalWatch = watch;
}

extension RepositoryRefX on Ref {

  Repository<RawAssignment> get rawAssignments => watch(rawAssignmentsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
  Repository<RawProject> get rawProjects => watch(rawProjectsRepositoryProvider)..remoteAdapter.internalWatch = watch as Watcher;
}