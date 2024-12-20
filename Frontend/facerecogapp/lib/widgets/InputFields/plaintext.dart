// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Plaintext extends StatefulWidget {
  final InputDecoration inputDecoration;
  final FormFieldValidator validator;
  final TextEditingController controller;
  final TextInputType type;
  const Plaintext({
    super.key,
    required this.inputDecoration,
    required this.validator,
    required this.controller,
    required this.type,
  });

  @override
  State<Plaintext> createState() => _PlaintextState();
}

class _PlaintextState extends State<Plaintext> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        decoration: widget.inputDecoration,
        validator: widget.validator,
        controller: widget.controller,
        keyboardType: widget.type,
      ),
    );
  }
}
