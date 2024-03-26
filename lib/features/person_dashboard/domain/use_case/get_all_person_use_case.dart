import 'package:flutter_interview/features/person_dashboard/domain/base_repo/base_get_all_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class GetAllPersonUseCase {
  final BaseGetAllPersonRepo baseGetAllPersonRepo;

  GetAllPersonUseCase(this.baseGetAllPersonRepo);

  Future<List<Person>> getAllPerson() async {
    try {
      return await baseGetAllPersonRepo.getAllPerson();
    } catch (e) {
      rethrow;
    }
  }
}
