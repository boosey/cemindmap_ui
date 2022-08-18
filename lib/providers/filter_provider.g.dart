// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_provider.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$FilterCWProxy {
  Filter accountSelection(String accountSelection);

  Filter allAccountNodes(Set<AccountNode> allAccountNodes);

  Filter allGeoNodes(Set<GeoNode> allGeoNodes);

  Filter allMarketNodes(Set<MarketNode> allMarketNodes);

  Filter allSquadNodes(Set<SquadNode> allSquadNodes);

  Filter geoSelection(String geoSelection);

  Filter marketSelection(String marketSelection);

  Filter searchTerms(String searchTerms);

  Filter squadSelection(String squadSelection);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Filter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Filter(...).copyWith(id: 12, name: "My name")
  /// ````
  Filter call({
    String? accountSelection,
    Set<AccountNode>? allAccountNodes,
    Set<GeoNode>? allGeoNodes,
    Set<MarketNode>? allMarketNodes,
    Set<SquadNode>? allSquadNodes,
    String? geoSelection,
    String? marketSelection,
    String? searchTerms,
    String? squadSelection,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfFilter.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfFilter.copyWith.fieldName(...)`
class _$FilterCWProxyImpl implements _$FilterCWProxy {
  final Filter _value;

  const _$FilterCWProxyImpl(this._value);

  @override
  Filter accountSelection(String accountSelection) =>
      this(accountSelection: accountSelection);

  @override
  Filter allAccountNodes(Set<AccountNode> allAccountNodes) =>
      this(allAccountNodes: allAccountNodes);

  @override
  Filter allGeoNodes(Set<GeoNode> allGeoNodes) =>
      this(allGeoNodes: allGeoNodes);

  @override
  Filter allMarketNodes(Set<MarketNode> allMarketNodes) =>
      this(allMarketNodes: allMarketNodes);

  @override
  Filter allSquadNodes(Set<SquadNode> allSquadNodes) =>
      this(allSquadNodes: allSquadNodes);

  @override
  Filter geoSelection(String geoSelection) => this(geoSelection: geoSelection);

  @override
  Filter marketSelection(String marketSelection) =>
      this(marketSelection: marketSelection);

  @override
  Filter searchTerms(String searchTerms) => this(searchTerms: searchTerms);

  @override
  Filter squadSelection(String squadSelection) =>
      this(squadSelection: squadSelection);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Filter(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Filter(...).copyWith(id: 12, name: "My name")
  /// ````
  Filter call({
    Object? accountSelection = const $CopyWithPlaceholder(),
    Object? allAccountNodes = const $CopyWithPlaceholder(),
    Object? allGeoNodes = const $CopyWithPlaceholder(),
    Object? allMarketNodes = const $CopyWithPlaceholder(),
    Object? allSquadNodes = const $CopyWithPlaceholder(),
    Object? geoSelection = const $CopyWithPlaceholder(),
    Object? marketSelection = const $CopyWithPlaceholder(),
    Object? searchTerms = const $CopyWithPlaceholder(),
    Object? squadSelection = const $CopyWithPlaceholder(),
  }) {
    return Filter(
      accountSelection: accountSelection == const $CopyWithPlaceholder() ||
              accountSelection == null
          ? _value.accountSelection
          // ignore: cast_nullable_to_non_nullable
          : accountSelection as String,
      allAccountNodes: allAccountNodes == const $CopyWithPlaceholder() ||
              allAccountNodes == null
          ? _value.allAccountNodes
          // ignore: cast_nullable_to_non_nullable
          : allAccountNodes as Set<AccountNode>,
      allGeoNodes:
          allGeoNodes == const $CopyWithPlaceholder() || allGeoNodes == null
              ? _value.allGeoNodes
              // ignore: cast_nullable_to_non_nullable
              : allGeoNodes as Set<GeoNode>,
      allMarketNodes: allMarketNodes == const $CopyWithPlaceholder() ||
              allMarketNodes == null
          ? _value.allMarketNodes
          // ignore: cast_nullable_to_non_nullable
          : allMarketNodes as Set<MarketNode>,
      allSquadNodes:
          allSquadNodes == const $CopyWithPlaceholder() || allSquadNodes == null
              ? _value.allSquadNodes
              // ignore: cast_nullable_to_non_nullable
              : allSquadNodes as Set<SquadNode>,
      geoSelection:
          geoSelection == const $CopyWithPlaceholder() || geoSelection == null
              ? _value.geoSelection
              // ignore: cast_nullable_to_non_nullable
              : geoSelection as String,
      marketSelection: marketSelection == const $CopyWithPlaceholder() ||
              marketSelection == null
          ? _value.marketSelection
          // ignore: cast_nullable_to_non_nullable
          : marketSelection as String,
      searchTerms:
          searchTerms == const $CopyWithPlaceholder() || searchTerms == null
              ? _value.searchTerms
              // ignore: cast_nullable_to_non_nullable
              : searchTerms as String,
      squadSelection: squadSelection == const $CopyWithPlaceholder() ||
              squadSelection == null
          ? _value.squadSelection
          // ignore: cast_nullable_to_non_nullable
          : squadSelection as String,
    );
  }
}

extension $FilterCopyWith on Filter {
  /// Returns a callable class that can be used as follows: `instanceOfFilter.copyWith(...)` or like so:`instanceOfFilter.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$FilterCWProxy get copyWith => _$FilterCWProxyImpl(this);
}
