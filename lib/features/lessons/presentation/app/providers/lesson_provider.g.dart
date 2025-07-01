// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savedLessonsHash() => r'd867c13907473f6bf0fe49197ebf59e33de5d0d5';

/// See also [savedLessons].
@ProviderFor(savedLessons)
final savedLessonsProvider = AutoDisposeFutureProvider<List<Lesson>>.internal(
  savedLessons,
  name: r'savedLessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$savedLessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SavedLessonsRef = AutoDisposeFutureProviderRef<List<Lesson>>;
String _$createdLessonsHash() => r'1fda2765500aa22a2fc9c7699690634d6b19d0d0';

/// See also [createdLessons].
@ProviderFor(createdLessons)
final createdLessonsProvider = AutoDisposeFutureProvider<List<Lesson>>.internal(
  createdLessons,
  name: r'createdLessonsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$createdLessonsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CreatedLessonsRef = AutoDisposeFutureProviderRef<List<Lesson>>;
String _$searchedLessonsHash() => r'05b73089885855c21d6a5863aa977a2486232092';

/// See also [searchedLessons].
@ProviderFor(searchedLessons)
final searchedLessonsProvider =
    AutoDisposeFutureProvider<List<Lesson>>.internal(
      searchedLessons,
      name: r'searchedLessonsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$searchedLessonsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchedLessonsRef = AutoDisposeFutureProviderRef<List<Lesson>>;
String _$filteredLessonsHash() => r'ba5a0fbb94b1ffe1ca6abf9f89dc86574af46670';

/// See also [filteredLessons].
@ProviderFor(filteredLessons)
final filteredLessonsProvider =
    AutoDisposeFutureProvider<List<Lesson>>.internal(
      filteredLessons,
      name: r'filteredLessonsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$filteredLessonsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredLessonsRef = AutoDisposeFutureProviderRef<List<Lesson>>;
String _$lessonDetailsHash() => r'05d8e8152320e61c4b9ebfc623859da568a16315';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [lessonDetails].
@ProviderFor(lessonDetails)
const lessonDetailsProvider = LessonDetailsFamily();

/// See also [lessonDetails].
class LessonDetailsFamily extends Family<AsyncValue<LessonDetails>> {
  /// See also [lessonDetails].
  const LessonDetailsFamily();

  /// See also [lessonDetails].
  LessonDetailsProvider call(String lessonId) {
    return LessonDetailsProvider(lessonId);
  }

  @override
  LessonDetailsProvider getProviderOverride(
    covariant LessonDetailsProvider provider,
  ) {
    return call(provider.lessonId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'lessonDetailsProvider';
}

/// See also [lessonDetails].
class LessonDetailsProvider extends AutoDisposeFutureProvider<LessonDetails> {
  /// See also [lessonDetails].
  LessonDetailsProvider(String lessonId)
    : this._internal(
        (ref) => lessonDetails(ref as LessonDetailsRef, lessonId),
        from: lessonDetailsProvider,
        name: r'lessonDetailsProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$lessonDetailsHash,
        dependencies: LessonDetailsFamily._dependencies,
        allTransitiveDependencies:
            LessonDetailsFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  LessonDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lessonId,
  }) : super.internal();

  final String lessonId;

  @override
  Override overrideWith(
    FutureOr<LessonDetails> Function(LessonDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LessonDetailsProvider._internal(
        (ref) => create(ref as LessonDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lessonId: lessonId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LessonDetails> createElement() {
    return _LessonDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonDetailsProvider && other.lessonId == lessonId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lessonId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LessonDetailsRef on AutoDisposeFutureProviderRef<LessonDetails> {
  /// The parameter `lessonId` of this provider.
  String get lessonId;
}

class _LessonDetailsProviderElement
    extends AutoDisposeFutureProviderElement<LessonDetails>
    with LessonDetailsRef {
  _LessonDetailsProviderElement(super.provider);

  @override
  String get lessonId => (origin as LessonDetailsProvider).lessonId;
}

String _$currentLessonFilterHash() =>
    r'b65cf32162db34ca52a810b26133c6bba3822ed8';

/// See also [CurrentLessonFilter].
@ProviderFor(CurrentLessonFilter)
final currentLessonFilterProvider =
    AutoDisposeNotifierProvider<CurrentLessonFilter, LessonFilter>.internal(
      CurrentLessonFilter.new,
      name: r'currentLessonFilterProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentLessonFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentLessonFilter = AutoDisposeNotifier<LessonFilter>;
String _$lessonSearchQueryHash() => r'cfcd74b544964914dcf1a0aee606fabb5c9b31c6';

/// See also [LessonSearchQuery].
@ProviderFor(LessonSearchQuery)
final lessonSearchQueryProvider =
    AutoDisposeNotifierProvider<LessonSearchQuery, String>.internal(
      LessonSearchQuery.new,
      name: r'lessonSearchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$lessonSearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LessonSearchQuery = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
