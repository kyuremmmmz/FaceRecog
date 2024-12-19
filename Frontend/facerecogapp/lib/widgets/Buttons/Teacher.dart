// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TeacherButton extends StatefulWidget {
  late Text buttonName;
  late VoidCallback callback;
  late ButtonStyle style;
  TeacherButton({
    super.key,
    required this.buttonName,
    required this.callback,
    required this.style
  });

  @override
  State<TeacherButton> createState() => _TeacherButtonState();
}

class _TeacherButtonState extends State<TeacherButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.callback,
      style: widget.style,
      child: widget.buttonName
      );
  }
}
