import 'package:flutter/material.dart';

class Columns extends StatefulWidget {
  final String avatarLabel;
  final String time;
  final String subject;
  const Columns({super.key, required this.avatarLabel, required this.time, required this.subject});

  @override
  State<Columns> createState() => _ColumnsState();
}

class _ColumnsState extends State<Columns> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            CircleAvatar(
                backgroundColor: Colors.blue,
                child: Text(
                  widget.avatarLabel,
                  style: TextStyle(color: Colors.white),
                )),
            
            Text(
              widget.subject,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            
            Text(
              widget.time,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
