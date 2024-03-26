import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/get_all_person_use_case.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  final GetAllPersonUseCase getAllPersonUseCase;

  PersonCubit(this.getAllPersonUseCase) : super(PersonInitial());
  static PersonCubit get(context) => BlocProvider.of<PersonCubit>(context);

  List<Person> persons = [];

  late int totalPage;
  static const int initialPage = 0;
  List<Person>? displayedItems;
  final int itemsPerPage = 2;

  void getAllPerson() async {
    emit(GetAllPersonLoadingState());
    try {
      persons = await getAllPersonUseCase.getAllPerson();
      _defineTotalPageNum();
      logger.i("Persons got successfully");
      emit(GetAllPersonSuccessState());
    } catch (error) {
      emit(GetAllPersonErrorState());
      logger.e("error while trying to get persons $error");
    }
  }

  int? selectedPageNumber = initialPage + 1;
  changePage(int pageNumber) {
    selectedPageNumber = pageNumber;
    displayedItems = _getDisplayedList(pageNumber - 1);
    emit(PaginationState());
  }

  void _defineTotalPageNum() {
    totalPage = (persons.length / itemsPerPage).ceil();

    displayedItems = _getDisplayedList(initialPage);
  }

  List<Person> _getDisplayedList(int page) {
    final startIndex = (page) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    final effectiveEndIndex =
        endIndex > persons.length ? persons.length : endIndex;

    List<Person> tempItems = persons.sublist(startIndex, effectiveEndIndex);

    return tempItems;
  }
}
