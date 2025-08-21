import '../../data/repositories/invetation_repo.dart';

class RejectInvetationUsecase {
    InvetationRepo repo;
  RejectInvetationUsecase({required this.repo});
 Future<void> call(String userId){
  return repo.rejectInvetaion(userId);
 }
 
}