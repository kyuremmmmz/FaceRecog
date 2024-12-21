// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Buttonwithicon extends StatefulWidget {
  late ButtonStyle style;
  late Text buttonLabel;
  late Icon? icon;
  late VoidCallback callback;
  Buttonwithicon({
    super.key,
    required this.style,
    required this.buttonLabel,
    this.icon,
    required this.callback,
  });

  @override
  State<Buttonwithicon> createState() => _ButtonwithiconState();
}

class _ButtonwithiconState extends State<Buttonwithicon> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: widget.style,
        icon: widget.icon,
        onPressed: widget.callback, 
        label: widget.buttonLabel
        );
  }
}
