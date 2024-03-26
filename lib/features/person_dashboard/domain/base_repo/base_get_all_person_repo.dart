import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

abstract class BaseGetAllPersonRepo {
  Future<List<Person>> getAllPerson();
}