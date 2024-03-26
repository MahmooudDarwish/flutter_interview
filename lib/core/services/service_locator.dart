import 'package:flutter_interview/features/person_dashboard/data/data_source/add_person_data_source.dart';
import 'package:flutter_interview/features/person_dashboard/data/data_source/get_all_person_data_source.dart';
import 'package:flutter_interview/features/person_dashboard/data/repo/add_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/data/repo/get_all_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/base_repo/add_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/base_repo/base_get_all_person_repo.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/add_person_use_case.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/get_all_person_use_case.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_add_cubit.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final sl = GetIt.instance;
final logger = Logger();

class ServicesLocator {
  void init() {
    /// DATA SOURCE
    sl.registerLazySingleton<BaseGetAllPersonDataSource>(
      () => GetAllPersonDataSource(),
    );
    sl.registerLazySingleton<BaseAddPersonDataSource>(
      () => AddPersonDataSource(),
    );

    /// Repository
    sl.registerLazySingleton<BaseGetAllPersonRepo>(
      () => GetAllPersonRepo(sl()),
    );
    sl.registerLazySingleton<BaseAddPersonRepo>(
      () => AddPersonRepo(sl()),
    );

    /// Use Cases
    sl.registerLazySingleton(
      () => GetAllPersonUseCase(sl()),
    );
    sl.registerLazySingleton(
      () => AddPersonUseCase(sl()),
    );

    /// Bloc
    sl.registerFactory(() => PersonCubit(sl()));
    sl.registerFactory(() => PersonAddCubit(sl()));
  }
}
