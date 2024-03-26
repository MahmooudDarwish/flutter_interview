import 'package:flutter/material.dart';
import 'package:flutter_interview/core/util/string_constance.dart';
import 'package:flutter_interview/features/person_dashboard/domain/model/person.dart';

class PersonItem extends StatelessWidget {
  final Person person;

  const PersonItem({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Colors.green,
        child: Column(
          children: [
            Text(
                "${StringConstance.personItemNameLabel} ${person.name.toString()}"),
            Text(
                "${StringConstance.personItemAgeLabel} ${person.age.toString()}"),
          ],
        ),
      ),
    );
  }
}
