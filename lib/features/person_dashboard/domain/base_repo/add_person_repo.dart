import 'package:flutter_interview/features/person_dashboard/domain/use_case/add_person_use_case.dart';

abstract class BaseAddPersonRepo {
  Future<void> addPerson(AddPersonParameters parameters);
}
