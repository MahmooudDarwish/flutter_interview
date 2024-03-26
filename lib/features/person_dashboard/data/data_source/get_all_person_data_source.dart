import 'package:flutter_interview/core/services/firebase_service.dart';
import 'package:flutter_interview/features/person_dashboard/data/model/person_model.dart';

abstract class BaseGetAllPersonDataSource {
  Future<List<PersonModel>> getAllPerson();
}

class GetAllPersonDataSource extends BaseGetAllPersonDataSource {
  @override
  Future<List<PersonModel>> getAllPerson() async {
    try {
      List<PersonModel> persons = [];
      final snapshot = await FirebaseService.getData();
      if (snapshot != null) {
        for (var element in snapshot.docs) {
          PersonModel person =
              PersonModel.fromMap(element.data() as Map<String, dynamic>);
          persons.add(person);
        }
        return persons;
      } else {
        return persons;
      }
    } catch (error) {
      rethrow;
    }
  }
}
