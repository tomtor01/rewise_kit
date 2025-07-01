import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../dashboard/data/models/user_data_model.dart';

abstract class DashboardRemoteDataSource {
  Future<UserDataModel> getUserData(String userId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final FirebaseFirestore _firestore;

  DashboardRemoteDataSourceImpl(this._firestore);

  @override
  Future<UserDataModel> getUserData(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists && doc.data() != null) {
      return UserDataModel.fromMap(doc.data()!);
    } else {
      return const UserDataModel.empty();
    }
  }
}
