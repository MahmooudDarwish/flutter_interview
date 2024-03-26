import 'package:flutter/material.dart';
import 'package:flutter_interview/core/util/string_constance.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class PersonDetails extends StatelessWidget {
  final Person person;
  const PersonDetails({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "${StringConstance.personIdLabel} ${person.personID.toString()}"),
            Text(
                "${StringConstance.personNameLabel} ${person.name.toString()}"),
            Text("${StringConstance.personAgeLabel} ${person.age.toString()}"),
            Text(
                "${StringConstance.personNationalIdLabel} ${person.nationalityID.toString()}"),
            Text(
                "${StringConstance.personBirthDateLabel} ${person.birthDate.toString()}"),
          ],
        ),
      ),
    );
  }
}
