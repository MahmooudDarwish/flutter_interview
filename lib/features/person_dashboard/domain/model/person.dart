import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final String personID;
  final String name;
  final int age;
  final int nationalityID;
  final String birthDate;

  const Person(
      {required this.personID,
      required this.name,
      required this.age,
      required this.nationalityID,
      required this.birthDate});

  @override
  List<Object?> get props => [personID, name, age, nationalityID, birthDate];
}
