import 'package:flutter_data/flutter_data.dart';

enum ViewSettings {
  showSectionsFlags,
  showGeoSection,
  showMarketSection,
  showSquadSection,
  showAccountSection,
  showProjectSection,
  showTalentSection,
  showAssignedTalentInProjectDetail,
  showFilterBar,
  showSearchBar,
}

class ViewSettingsNotifier extends StateNotifier<Map<ViewSettings, dynamic>> {
  ViewSettingsNotifier(super.state);

  setViewSetting(ViewSettings setting, dynamic value) {
    state.update(setting, (value) => value, ifAbsent: () => value);
    state = Map.of(state);
  }
}

final viewSettingsProvider =
    StateNotifierProvider<ViewSettingsNotifier, Map<ViewSettings, dynamic>>(
        (ref) => ViewSettingsNotifier({
              ViewSettings.showSectionsFlags: [
                true,
                true,
                true,
                true,
                true,
                true
              ],
              ViewSettings.showAssignedTalentInProjectDetail: true,
              ViewSettings.showFilterBar: true,
              ViewSettings.showSearchBar: true,
            }));
