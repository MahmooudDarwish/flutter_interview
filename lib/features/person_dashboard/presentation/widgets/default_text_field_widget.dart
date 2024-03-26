import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType type;
  final FormFieldValidator validate;
  final String label;
  final Widget prefix;
  final bool isClickable;
  final int maxLength;
  final bool onlyNumber;
  final void Function()? prefixPressed;

  const DefaultTextFormField(
      {super.key,
      required this.controller,
      required this.type,
      required this.validate,
      required this.label,
      required this.prefix,
      this.isClickable = true,
      this.maxLength = 30,
      this.onlyNumber = false,
      this.prefixPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        maxLength: maxLength,
        enabled: isClickable,
        controller: controller,
        keyboardType: type,
        validator: validate,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: IconButton(
            onPressed: prefixPressed,
            icon: prefix,
          ),
          border: const OutlineInputBorder(),
        ),
        inputFormatters: onlyNumber
            ? [
                FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
              ]
            : [],
      ),
    );
  }
}
