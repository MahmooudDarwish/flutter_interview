import 'package:equatable/equatable.dart';
import 'package:flutter_interview/features/person_dashboard/domain/base_repo/add_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class AddPersonUseCase {
  final BaseAddPersonRepo baseAddPersonRepo;
  AddPersonUseCase(this.baseAddPersonRepo);
  Future<void> addPerson(AddPersonParameters parameters) async {
    try {
      return await baseAddPersonRepo.addPerson(parameters);
    } catch (e) {
      rethrow;
    }
  }
}

class AddPersonParameters extends Equatable {
  final Person person;

  const AddPersonParameters({required this.person});

  Map<String, dynamic> toMap() {
    return {
      'personId': person.personID,
      'name': person.name,
      'age': person.age,
      'nationalityId': person.nationalityID,
      'birthDate': person.birthDate,
    };
  }

  @override
  List<Object> get props => [person];
}
