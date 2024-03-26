import 'dart:async';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/core/util/string_constance.dart';
import 'package:flutter_interview/core/util/util_functions.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';
import 'package:flutter_interview/features/person_dashboard/domain/use_case/add_person_use_case.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/views/country_selector.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/pagination_widget.dart';

part 'person_add_state.dart';

class PersonAddCubit extends Cubit<PersonAddState>
    with PaginationMixin<String> {
  final AddPersonUseCase addPersonUseCase;
  PersonAddCubit(this.addPersonUseCase) : super(PersonAddInitial()) {
    initialPage = 0;
    itemsPerPage = 4;
    items = StringConstance.countries;
    displayedItems = getDisplayedList(initialPage);
    defineTotalPageNum(items: StringConstance.countries);
  }

  static PersonAddCubit get(context) => BlocProvider.of(context);

  List<String> filteredCountries = [];

  DateTime? selectedDate;
  Country? selectedCountry;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController searchController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void addPerson() async {
    emit(AddPersonLoadingState());
    Person person = Person(
      personID: UtilFunction.generateId(),
      name: nameController.text,
      age: int.parse(ageController.text),
      nationalityID: int.parse(nationalIdController.text),
      birthDate: dateController.text,
    );
    try {
      await addPersonUseCase.addPerson(AddPersonParameters(person: person));
      logger.i("Person Added Successfully $person");
      emit(AddPersonSuccessState());
    } catch (error) {
      emit(AddPersonErrorState());
      logger.e("Error while trying to add Person $error");
    }
  }

  void pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateController.text =
          "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}";
      logger.i("New Time Picked $picked");

      emit(DatePickedState());
    }
  }

  Future<void> pickCountry(BuildContext context) async {
    final completer = Completer<void>();

    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        selectedCountry = country;
        logger.i("New Country Picked ${country.name}");

        completer.complete(); // Complete the Future when country is selected
      },
    );

    await completer.future; // Wait for the completer to complete
    emit(CountryPickedState());
  }

  Future<void> showPicker(
      BuildContext context, PersonAddCubit personAddCubit) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CountrySelector(
          personAddCubit: personAddCubit,
        );
      },
    );
    emit(CountryPickedState());
  }

  Future<void> searchControllerChange(String value) async {
    filteredCountries = StringConstance.countries
        .where((country) => country.toLowerCase().contains(value.toLowerCase()))
        .toList();
    emit(SearchCountryState());
  }

  String? pickedCountry;
  Future<void> selectCountry(String country) async {
    pickedCountry = country;
    emit(SelectCountryState());
  }

  @override
  Future<void> close() async {
    nameController.dispose();
    ageController.dispose();
    nationalIdController.dispose();
    countryController.dispose();
    dateController.dispose();
    searchController.dispose();
    numberPaginatorController.dispose();
    super.close();
  }

}
