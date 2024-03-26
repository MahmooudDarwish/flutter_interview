import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/get_all_person_use_case.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/pagination_widget.dart';
import 'package:number_paginator/number_paginator.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> with PaginationMixin<Person> {
  final GetAllPersonUseCase getAllPersonUseCase;

  final NumberPaginatorController numberPaginatorController =
      NumberPaginatorController();

  PersonCubit(this.getAllPersonUseCase) : super(PersonInitial()) {
    initialPage = 0;
    itemsPerPage = 2;
  }
  static PersonCubit get(context) => BlocProvider.of<PersonCubit>(context);

  List<Person> persons = [];

  void getAllPerson() async {
    emit(GetAllPersonLoadingState());
    try {
      persons = await getAllPersonUseCase.getAllPerson();
      items = persons;
      defineTotalPageNum(items: persons);
      logger.i("Persons got successfully");
      emit(GetAllPersonSuccessState());
    } catch (error) {
      emit(GetAllPersonErrorState());
      logger.e("error while trying to get persons $error");
    }
  }

  @override
  void goToPage(
      {required NumberPaginatorController controller, required int page}) {
    super.goToPage(controller: controller, page: page);
    emit(PaginationState());
  }

  @override
  void goToFirstPage({required NumberPaginatorController controller}) {
    super.goToFirstPage(controller: controller);
    emit(PaginationState());
  }

  @override
  void goToLastPage({required NumberPaginatorController controller}) {
    super.goToLastPage(controller: controller);
    emit(PaginationState());
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
