import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  final FormFieldValidator validator;
  final TextEditingController controller;
  const Email({super.key, required this.validator, required this.controller});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: widget.controller,
        decoration: const InputDecoration(
          labelText: 'Email',
          floatingLabelStyle: TextStyle(
            color: Colors.black
          ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black45,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.0,
              ),
            ),
          ),
          validator: widget.validator,
          keyboardType: TextInputType.emailAddress,
      ),
    );
  }
}
