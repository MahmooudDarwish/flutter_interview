import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class PersonModel extends Person {
  const PersonModel(
      {required super.personID,
      required super.name,
      required super.age,
      required super.nationalityID,
      required super.birthDate});

  factory PersonModel.fromMap(Map<String, dynamic> json) {
    return PersonModel(
        personID: json['personId'],
        name: json['name'],
        age: json['age'],
        nationalityID: json['nationalityId'],
        birthDate: json['birthDate']);
  }
}
