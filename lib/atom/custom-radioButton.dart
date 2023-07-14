import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final Function() onClick;

  const CustomRadioButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Radio(
            value: isSelected,
            groupValue: true,
            onChanged: (_) => onClick(),
            activeColor: Colors.blue,
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'PublicaSans',
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
            ),
          ),
        ),
      ],
    );
  }
}
