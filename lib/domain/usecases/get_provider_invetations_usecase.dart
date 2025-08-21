import '../../data/repositories/invetation_repo.dart';

class GetProviderInvetationsUsecase {
  InvetationRepo repo;
  GetProviderInvetationsUsecase({required this.repo});
 Future<Map<String,dynamic>> call(String userId){
  return repo.getInvetations(userId);
 }
 
  }