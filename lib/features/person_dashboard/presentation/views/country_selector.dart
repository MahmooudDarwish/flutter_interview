import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_add_cubit.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/country_builder_widget.dart';
import 'package:number_pagination/number_pagination.dart';

class CountrySelector extends StatelessWidget {
  final PersonAddCubit personAddCubit;

  const CountrySelector({super.key, required this.personAddCubit});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonAddCubit, PersonAddState>(
      listener: (context, state) {
        if (state is SelectCountryState) {
          Navigator.pop(context);
        }
      },
      bloc: personAddCubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (value) {
                    personAddCubit.searchControllerChange(value);
                  },
                  controller: personAddCubit.searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search Country',
                    hintText: 'Enter country name',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              if (personAddCubit.filteredCountries.isNotEmpty &&
                  personAddCubit.searchController.text.isNotEmpty)
                CountryBuilder(
                  countries: personAddCubit.filteredCountries,
                  personAddCubit: personAddCubit,
                ),
              CountryBuilder(
                countries: personAddCubit.displayedItems!,
                personAddCubit: personAddCubit,
              ),
              NumberPagination(
                onPageChanged: (int pageNumber) {
                  //do somthing for selected page
                  personAddCubit.changePage(pageNumber);
                },
                threshold: personAddCubit.totalPage,
                pageTotal: personAddCubit.totalPage,
                pageInit: personAddCubit
                    .selectedPageNumber, // picked number when init page
                iconToFirst: const Icon(Icons.keyboard_double_arrow_left),
                iconToLast: const Icon(Icons.keyboard_double_arrow_right),
              ),
            ],
          ),
        );
      },
    );
  }
}
