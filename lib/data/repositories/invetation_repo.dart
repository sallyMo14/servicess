abstract class InvetationRepo {

  Future<Map<String,dynamic>> getInvetations(String userId);
  Future<void> acceptInvetaion(String invId);
  Future<void> rejectInvetaion(String invId);

}