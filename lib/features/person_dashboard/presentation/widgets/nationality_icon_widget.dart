import 'package:flutter/material.dart';
import 'package:flutter_interview/core/util/string_constance.dart';

class NationalityIcon extends StatelessWidget {
  final String? countryName;
  const NationalityIcon({super.key, required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 150,
          child: Text(
            countryName ?? StringConstance.personCountryLabel,
            style: const TextStyle(
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const Icon(
          Icons.expand_circle_down,
          size: 40,
        ),
      ],
    );
  }
}
