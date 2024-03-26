import 'package:flutter/material.dart';
import 'package:flutter_interview/core/util/string_constance.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/views/person_add_form.dart';

class PersonAddButton extends StatelessWidget {
  const PersonAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const PersonAddForm(),
          ));
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 40,
              color: Colors.grey,
            ),
            Text(
              StringConstance.personAddButtonLabel,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ));
  }
}
