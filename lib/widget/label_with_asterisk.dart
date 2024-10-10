import 'package:flutter/material.dart';

class LabelWithAsterisk extends StatelessWidget {
  final String labelText;
  final bool isRequired;

  const LabelWithAsterisk({
    Key? key,
    required this.labelText,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          labelText,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isRequired)
          Text(
            "*",
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }
}
