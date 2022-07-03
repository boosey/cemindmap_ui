// The StateNotifier class that will be passed to our StateNotifierProvider.
// This class should not expose state outside of its "state" property, which means
// no public getters/properties!
// The public methods on this class will be what allow the UI to modify the state.

import 'package:flutter_data/flutter_data.dart';
import '../models/project.dart';
import '../models/projects_structure.dart';

class ProjectStructureStateNotifier extends StateNotifier<ProjectStructure> {
  ProjectStructureStateNotifier({
    required this.projects,
    // required this.viewBySelection,
    // required this.geoSelection,
    // required this.marketSelection,
    // required this.squadSelection,
    // required this.accountSelection,
  }) : super(ProjectStructure(projects));

  final List<Project> projects;
  // final ViewByChoice viewBySelection;
  // final String geoSelection;
  // final String marketSelection;
  // final String squadSelection;
  // final String accountSelection;
}
