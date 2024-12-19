// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Studentbutton extends StatefulWidget {
  late ButtonStyle style;
  late Text buttonLabel;
  late VoidCallback callback;
  Studentbutton({
    super.key,
    required this.style,
    required this.buttonLabel,
    required this.callback,
  });

  @override
  State<Studentbutton> createState() => _StudentbuttonState();
}

class _StudentbuttonState extends State<Studentbutton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.callback, 
      style: widget.style,
      child: widget.buttonLabel,
      );
  }
}
