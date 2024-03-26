part of 'person_add_cubit.dart';

@immutable
sealed class PersonAddState {}

final class PersonAddInitial extends PersonAddState {}

final class AddPersonSuccessState extends PersonAddState {}

final class AddPersonErrorState extends PersonAddState {}

final class AddPersonLoadingState extends PersonAddState {}

final class DatePickedState extends PersonAddState {}

final class CountryPickedState extends PersonAddState {}

final class SearchCountryState extends PersonAddState {}

final class SelectCountryState extends PersonAddState {}

final class PaginationState extends PersonAddState {}

