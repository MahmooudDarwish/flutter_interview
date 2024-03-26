part of 'person_cubit.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

final class GetAllPersonSuccessState extends PersonState {}

final class GetAllPersonErrorState extends PersonState {}

final class GetAllPersonLoadingState extends PersonState {}

final class PaginationState extends PersonState {}

