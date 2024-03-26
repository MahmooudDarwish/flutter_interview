import 'package:flutter_interview/features/person_dashboard/data/data_source/add_person_data_source.dart';
import 'package:flutter_interview/features/person_dashboard/domain/base_repo/add_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/add_person_use_case.dart';

class AddPersonRepo extends BaseAddPersonRepo {
  final BaseAddPersonDataSource baseAddPersonDataSource;
  AddPersonRepo(this.baseAddPersonDataSource);
  @override
  Future<void> addPerson(AddPersonParameters parameters) async {
    try {
      await baseAddPersonDataSource.addPerson(parameters);
    } catch (e) {
      rethrow;
    }
  }
}
