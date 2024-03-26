import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_cubit.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/person_add_button_widget.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/person_item_widget.dart';
import 'package:gap/gap.dart';
import 'package:number_pagination/number_pagination.dart';

class PersonDashboard extends StatelessWidget {
  const PersonDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonCubit>()..getAllPerson(),
      child: const PersonDashboardView(),
    );
  }
}

class PersonDashboardView extends StatelessWidget {
  const PersonDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonCubit.get(context);
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              if (cubit.persons.isNotEmpty)
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return PersonItem(person: cubit.displayedItems![index]);
                      },
                      separatorBuilder: (context, index) {
                        return const Gap(15);
                      },
                      itemCount: cubit.displayedItems!.length),
                ),
              if (cubit.persons.isNotEmpty)
                NumberPagination(
                  onPageChanged: (int pageNumber) {
                    cubit.changePage(pageNumber);
                  },
                  threshold: cubit.totalPage,
                  pageTotal: cubit.totalPage,
                  pageInit: cubit.selectedPageNumber!,
                  iconToFirst: const Icon(Icons.keyboard_double_arrow_left),
                  iconToLast: const Icon(Icons.keyboard_double_arrow_right),
                ),
              const PersonAddButton(),
            ],
          ),
        );
      },
    );
  }
}
