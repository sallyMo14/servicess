import '../../data/repositories/invetation_repo.dart';

class AcceptInvetationUsecase {
    InvetationRepo repo;
  AcceptInvetationUsecase({required this.repo});
 Future<void> call(String userId){
  return repo.acceptInvetaion(userId);
 }
 
}