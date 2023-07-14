import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordInput extends StatelessWidget {
  final String hintText;
  final String imagePath;
  final TextInputType keyboardType;
  final ValueChanged<String> onChangeText;
  final bool showPassword;
  final Function() showHidePassword;

  const PasswordInput(
      {Key? key,
      required this.hintText,
      this.imagePath = "",
      this.keyboardType = TextInputType.name,
      required this.onChangeText,
      required this.showPassword,
      required this.showHidePassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      width: deviceWidth - 40,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFD2DBD6),
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            imagePath.split(".").contains("png")
                ? Image.asset(
                    imagePath,
                    width: 15.0,
                    height: 15.0,
                  )
                : SvgPicture.asset(imagePath),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                keyboardType: keyboardType,
                onChanged: onChangeText,
                obscureText: showPassword,
                style: const TextStyle(
                  fontFamily: 'PublicaSans',
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                  height: 16.98 / 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    fontFamily: 'PublicaSans',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w300,
                    fontSize: 14.0,
                    height: 16.8 / 14,
                    letterSpacing: 0.0,
                    color: Color(0xFF939EAA),
                  ),
                ),
                cursorColor: Color(0xFF000000),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            GestureDetector(
                onTap: showHidePassword,
                child: SvgPicture.asset(
                  showPassword?"assets/images/svg/eye.svg":"assets/images/svg/eye.svg",
                  width: 15.0,
                  height: 9.0,
                )),
          ],
        ),
      ),
    );
  }
}
