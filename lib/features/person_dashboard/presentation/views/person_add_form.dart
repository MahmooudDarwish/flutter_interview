import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_interview/core/services/service_locator.dart';
import 'package:flutter_interview/core/util/string_constance.dart';
import 'package:flutter_interview/core/util/util_functions.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/controller/person_add_cubit.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/views/person_dashboard.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/default_text_field_widget.dart';
import 'package:flutter_interview/features/person_dashboard/presentation/widgets/nationality_icon_widget.dart';

class PersonAddForm extends StatelessWidget {
  const PersonAddForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PersonAddCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: const PersonAddFormView(),
      ),
    );
  }
}

class PersonAddFormView extends StatelessWidget {
  const PersonAddFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = PersonAddCubit.get(context);
    return BlocConsumer<PersonAddCubit, PersonAddState>(
      listener: (context, state) {
        if (state is AddPersonSuccessState) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const PersonDashboard(),
          ));
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DefaultTextFormField(
                    label: StringConstance.nameLabel,
                    controller: cubit.nameController,
                    prefix: const Icon(Icons.person),
                    type: TextInputType.text,
                    validate: (value) => UtilFunction.validateField(
                        value, StringConstance.nameLabel),
                  ),
                  DefaultTextFormField(
                    label: StringConstance.ageLabel,
                    controller: cubit.ageController,
                    prefix: const Icon(Icons.calendar_month_sharp),
                    type: TextInputType.number,
                    validate: (value) => UtilFunction.validateField(
                        value, StringConstance.ageLabel),
                    maxLength: 2,
                    onlyNumber: true,
                  ),
                  DefaultTextFormField(
                    label: StringConstance.nationalIdLabel,
                    controller: cubit.nationalIdController,
                    prefix: NationalityIcon(
                      countryName: cubit.pickedCountry,
                    ),
                    prefixPressed: () => cubit.showPicker(context, cubit),
                    type: TextInputType.number,
                    validate: (value) => UtilFunction.validateField(
                        value, StringConstance.nationalIdLabel),
                    maxLength: 14,
                    onlyNumber: true,
                  ),
                  DefaultTextFormField(
                    label: StringConstance.nationalIdLabel,
                    controller: cubit.countryController,
                    prefix: NationalityIcon(
                      countryName: cubit.selectedCountry?.name,
                    ),
                    prefixPressed: () => cubit.pickCountry(context),
                    type: TextInputType.number,
                    validate: (value) => UtilFunction.validateField(
                        value, StringConstance.nationalIdLabel),
                    maxLength: 14,
                    onlyNumber: true,
                  ),
                  InkWell(
                    onTap: () => cubit.pickDate(context),
                    // Call method to show date picker
                    child: DefaultTextFormField(
                      label: StringConstance.birthDateLabel,
                      prefix: const Icon(Icons.calendar_today),
                      controller: cubit.dateController,
                      type: TextInputType.datetime,
                      validate: (value) => UtilFunction.validateField(
                          value, StringConstance.birthDateLabel),
                      isClickable: false,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.addPerson();
                      }
                    },
                    child: const Text(StringConstance.submitButtonText),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
