import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rewise_kit/core/common/providers/current_user_provider.dart';
import 'package:rewise_kit/core/services/injection_container.dart';

import '../../../domain/entities/user_data.dart';
import '../../../domain/usecases/get_user_data.dart';

part 'user_data_notifier.g.dart';

@riverpod
class UserDataNotifier extends _$UserDataNotifier {
  late final GetUserDataUseCase _getUserData;

  @override
  Future<UserData?> build() {
    _getUserData = sl<GetUserDataUseCase>();
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser == null) {
      return Future.value(null);
    }
    return _fetchUserData(currentUser.uid);
  }

  Future<UserData?> _fetchUserData(String uid) async {
    final result = await _getUserData(GetUserDataParams(userId: uid));
    return result.fold(
          (failure) => throw failure,
          (userData) => userData,
    );
  }
}