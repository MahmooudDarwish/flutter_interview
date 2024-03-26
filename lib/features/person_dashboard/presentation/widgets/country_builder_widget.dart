import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_add_cubit.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/country_card_widget.dart';

class CountryBuilder extends StatelessWidget {
  final List<String> countries;
  final PersonAddCubit personAddCubit;

  const CountryBuilder(
      {super.key, required this.countries, required this.personAddCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonAddCubit, PersonAddState>(
      bloc: personAddCubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: countries.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  personAddCubit.selectCountry(countries[index]);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CountryCard(country: countries[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
