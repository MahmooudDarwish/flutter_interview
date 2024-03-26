import 'package:flutter_interview/core/services/firebase_service.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/add_person_use_case.dart';

abstract class BaseAddPersonDataSource {
  Future<void> addPerson(AddPersonParameters parameters);
}

class AddPersonDataSource extends BaseAddPersonDataSource {
  @override
  Future<void> addPerson(AddPersonParameters parameters) async {
    try {
      await FirebaseService.addData(parameters.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
