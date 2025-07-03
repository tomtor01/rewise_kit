// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashcardsBySetHash() => r'13655fd43b9d6ea096c618e7f93368a542052440';

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

/// See also [flashcardsBySet].
@ProviderFor(flashcardsBySet)
const flashcardsBySetProvider = FlashcardsBySetFamily();

/// See also [flashcardsBySet].
class FlashcardsBySetFamily extends Family<AsyncValue<List<Flashcard>>> {
  /// See also [flashcardsBySet].
  const FlashcardsBySetFamily();

  /// See also [flashcardsBySet].
  FlashcardsBySetProvider call(String setId) {
    return FlashcardsBySetProvider(setId);
  }

  @override
  FlashcardsBySetProvider getProviderOverride(
    covariant FlashcardsBySetProvider provider,
  ) {
    return call(provider.setId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'flashcardsBySetProvider';
}

/// See also [flashcardsBySet].
class FlashcardsBySetProvider
    extends AutoDisposeFutureProvider<List<Flashcard>> {
  /// See also [flashcardsBySet].
  FlashcardsBySetProvider(String setId)
    : this._internal(
        (ref) => flashcardsBySet(ref as FlashcardsBySetRef, setId),
        from: flashcardsBySetProvider,
        name: r'flashcardsBySetProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$flashcardsBySetHash,
        dependencies: FlashcardsBySetFamily._dependencies,
        allTransitiveDependencies:
            FlashcardsBySetFamily._allTransitiveDependencies,
        setId: setId,
      );

  FlashcardsBySetProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.setId,
  }) : super.internal();

  final String setId;

  @override
  Override overrideWith(
    FutureOr<List<Flashcard>> Function(FlashcardsBySetRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardsBySetProvider._internal(
        (ref) => create(ref as FlashcardsBySetRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        setId: setId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Flashcard>> createElement() {
    return _FlashcardsBySetProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardsBySetProvider && other.setId == setId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, setId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FlashcardsBySetRef on AutoDisposeFutureProviderRef<List<Flashcard>> {
  /// The parameter `setId` of this provider.
  String get setId;
}

class _FlashcardsBySetProviderElement
    extends AutoDisposeFutureProviderElement<List<Flashcard>>
    with FlashcardsBySetRef {
  _FlashcardsBySetProviderElement(super.provider);

  @override
  String get setId => (origin as FlashcardsBySetProvider).setId;
}

String _$flashcardSetsByLessonHash() =>
    r'8e7731f67b7ebd417e9ce7b7e20796c68818326d';

/// See also [flashcardSetsByLesson].
@ProviderFor(flashcardSetsByLesson)
const flashcardSetsByLessonProvider = FlashcardSetsByLessonFamily();

/// See also [flashcardSetsByLesson].
class FlashcardSetsByLessonFamily
    extends Family<AsyncValue<List<FlashcardSet>>> {
  /// See also [flashcardSetsByLesson].
  const FlashcardSetsByLessonFamily();

  /// See also [flashcardSetsByLesson].
  FlashcardSetsByLessonProvider call(String lessonId) {
    return FlashcardSetsByLessonProvider(lessonId);
  }

  @override
  FlashcardSetsByLessonProvider getProviderOverride(
    covariant FlashcardSetsByLessonProvider provider,
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
  String? get name => r'flashcardSetsByLessonProvider';
}

/// See also [flashcardSetsByLesson].
class FlashcardSetsByLessonProvider
    extends AutoDisposeFutureProvider<List<FlashcardSet>> {
  /// See also [flashcardSetsByLesson].
  FlashcardSetsByLessonProvider(String lessonId)
    : this._internal(
        (ref) =>
            flashcardSetsByLesson(ref as FlashcardSetsByLessonRef, lessonId),
        from: flashcardSetsByLessonProvider,
        name: r'flashcardSetsByLessonProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$flashcardSetsByLessonHash,
        dependencies: FlashcardSetsByLessonFamily._dependencies,
        allTransitiveDependencies:
            FlashcardSetsByLessonFamily._allTransitiveDependencies,
        lessonId: lessonId,
      );

  FlashcardSetsByLessonProvider._internal(
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
    FutureOr<List<FlashcardSet>> Function(FlashcardSetsByLessonRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardSetsByLessonProvider._internal(
        (ref) => create(ref as FlashcardSetsByLessonRef),
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
  AutoDisposeFutureProviderElement<List<FlashcardSet>> createElement() {
    return _FlashcardSetsByLessonProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardSetsByLessonProvider && other.lessonId == lessonId;
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
mixin FlashcardSetsByLessonRef
    on AutoDisposeFutureProviderRef<List<FlashcardSet>> {
  /// The parameter `lessonId` of this provider.
  String get lessonId;
}

class _FlashcardSetsByLessonProviderElement
    extends AutoDisposeFutureProviderElement<List<FlashcardSet>>
    with FlashcardSetsByLessonRef {
  _FlashcardSetsByLessonProviderElement(super.provider);

  @override
  String get lessonId => (origin as FlashcardSetsByLessonProvider).lessonId;
}

String _$flashcardSetActionsHash() =>
    r'b8133397d7ed378aac7ec4ae09e06d4340a2ef87';

/// See also [FlashcardSetActions].
@ProviderFor(FlashcardSetActions)
final flashcardSetActionsProvider =
    AutoDisposeNotifierProvider<FlashcardSetActions, void>.internal(
      FlashcardSetActions.new,
      name: r'flashcardSetActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$flashcardSetActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FlashcardSetActions = AutoDisposeNotifier<void>;
String _$flashcardActionsHash() => r'7e8fa2407fe613b38e3c582d2b2b82049a8e273b';

/// See also [FlashcardActions].
@ProviderFor(FlashcardActions)
final flashcardActionsProvider =
    AutoDisposeNotifierProvider<FlashcardActions, void>.internal(
      FlashcardActions.new,
      name: r'flashcardActionsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$flashcardActionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FlashcardActions = AutoDisposeNotifier<void>;
String _$flashcardStudyHash() => r'290f08e6f62840c0527c4a48dda71c10639da9ed';

/// See also [FlashcardStudy].
@ProviderFor(FlashcardStudy)
final flashcardStudyProvider =
    AutoDisposeNotifierProvider<FlashcardStudy, FlashcardStudyState>.internal(
      FlashcardStudy.new,
      name: r'flashcardStudyProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$flashcardStudyHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FlashcardStudy = AutoDisposeNotifier<FlashcardStudyState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
