import 'package:flutter/material.dart';

// ignore: camel_case_types
class passwordTextField extends StatefulWidget {
  final String? text;
  final TextEditingController? password;
  final FormFieldValidator validator;

  const passwordTextField({
    super.key,
    required this.text,
    required this.password,
    required this.validator,
  });

  @override
  State<passwordTextField> createState() => _numberTextFieldState();
}

// ignore: camel_case_types
class _numberTextFieldState extends State<passwordTextField> {
  // ignore: non_constant_identifier_names
  bool _IsObsucure = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: widget.password,
        validator: widget.validator,
        decoration: InputDecoration(
            labelText: widget.text,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _IsObsucure = !_IsObsucure;
                  });
                },
                icon: Icon(
                    _IsObsucure ? Icons.visibility : Icons.visibility_off,
                    color: Colors.black)),
            labelStyle: const TextStyle(color: Colors.black),
            alignLabelWithHint: true,
            
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black))),
        style: const TextStyle(fontSize: 15, color: Colors.black),
        obscureText: _IsObsucure,
      ),
    );
  }
}
