import 'package:flutter/cupertino.dart';
import 'package:flutter_interview/features/person_dashboard/data/data_source/get_all_person_data_source.dart';
import 'package:flutter_interview/features/person_dashboard/domain/base_repo/base_get_all_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class GetAllPersonRepo extends BaseGetAllPersonRepo {
  final BaseGetAllPersonDataSource baseGetAllPersonDataSource;
  GetAllPersonRepo(this.baseGetAllPersonDataSource);

  @override
  Future<List<Person>> getAllPerson() async {
    final result = await baseGetAllPersonDataSource.getAllPerson();
    try {
      return result;
    } catch (error) {
      debugPrint('$error');
      rethrow;
    }
  }
}
