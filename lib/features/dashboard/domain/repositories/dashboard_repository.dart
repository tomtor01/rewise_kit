import '../../../../core/common/utils/typedefs.dart';
import '../../../dashboard/domain/entities/user_data.dart';

abstract class DashboardRepository {
  FutureResult<UserData> getUserData({required String userId});
}