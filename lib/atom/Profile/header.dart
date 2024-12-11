import 'package:flutter/material.dart';

class HeaderWithActionButton extends StatelessWidget {
  final String headerText;
  

  const HeaderWithActionButton({Key? key, required this.headerText,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    return Row(
      children: [
        Expanded(
          flex: 1,
            child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        )),
        Expanded(
          flex: 3,
            child: Text(
          headerText,
          style: const TextStyle(
            fontFamily: 'PublicaSans',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
            letterSpacing: 0,
            color: Color(0xFFFFFFFF),
          ),
        )),
       
      ],
    );
  }
}