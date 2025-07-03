// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProgressStatsHash() => r'0bf7e0a781b4e96c7ae0eb4506eca49a810d6537';

/// See also [userProgressStats].
@ProviderFor(userProgressStats)
final userProgressStatsProvider =
    AutoDisposeFutureProvider<UserProgressStats>.internal(
      userProgressStats,
      name: r'userProgressStatsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userProgressStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserProgressStatsRef = AutoDisposeFutureProviderRef<UserProgressStats>;
String _$userDataNotifierHash() => r'63c012085eaf0dca8f1a8a4129e78ab72436ba57';

/// See also [UserDataNotifier].
@ProviderFor(UserDataNotifier)
final userDataNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UserDataNotifier, UserData?>.internal(
      UserDataNotifier.new,
      name: r'userDataNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$userDataNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserDataNotifier = AutoDisposeAsyncNotifier<UserData?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
