import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String country;

  const CountryCard({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          country,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}