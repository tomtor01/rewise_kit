import '../../../../core/common/utils/typedefs.dart';
import '../../../dashboard/domain/entities/user_data.dart';

abstract class DashboardRepository {
  FutureResult<UserData> getUserData({required String userId});

  FutureResult<void> markFlashcard({
    required String flashcardId,
    required bool isLearned,
  });
}