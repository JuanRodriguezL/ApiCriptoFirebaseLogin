import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPassField;
  final String? hintTextField;
  final String? labeltextField;
  final String? helperTextField;

  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onSubmmitted;
  final TextInputType? inputType;

  const FormWidget(
      {this.controller,
      this.fieldKey,
      this.isPassField,
      this.hintTextField,
      this.labeltextField,
      this.helperTextField,
      this.validator,
      this.onSaved,
      this.onSubmmitted,
      this.inputType});

  @override
  State<FormWidget> createState() => FormWidgetState();
}

class FormWidgetState extends State<FormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.35),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        controller: widget.controller,
        keyboardType: widget.inputType,
        key: widget.fieldKey,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onSubmmitted,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            hintText: widget.hintTextField,
            hintStyle: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
