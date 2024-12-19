import 'package:flutter/material.dart';

class Email extends StatefulWidget {
  final FormFieldValidator validator;
  const Email({super.key, required this.validator});

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
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
