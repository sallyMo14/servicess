import '../data_sources/invetation_remote_data_source.dart';
import '../repositories/invetation_repo.dart';

class InvetationRepoImpl implements InvetationRepo {
  InvetationRemoteDataSource invetationRemoteDataSource;
  InvetationRepoImpl({required this.invetationRemoteDataSource});
  @override
  Future<Map<String, dynamic>> getInvetations(String userId) {
    return invetationRemoteDataSource.getInvitations(userId);
  }

  @override
  Future<void> acceptInvetaion(String invId) {
    // return invetationRemoteDataSource.acceptInvitation(invId);
    throw Exception();
  }

  @override
  Future<void> rejectInvetaion(String invId) {
    throw Exception();
    // return invetationRemoteDataSource.rejectInvitation(invId);
  }
}
