import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextInput extends StatefulWidget {
  final String hintText;
  final String imagePath;
  final TextInputType keyboardType;
  final ValueChanged<String> onChangeText;
  final void Function()? onClick;
  final String? value;
  final bool isDisabled;
  final String? additionalImagePath;
  final void Function()? onPressBack;

  const CustomTextInput(
      {Key? key,
      required this.hintText,
      this.imagePath = "",
      this.keyboardType = TextInputType.name,
      this.onClick,
      required this.onChangeText,
      this.value,
      this.isDisabled = false,
      this.additionalImagePath,
      this.onPressBack,
      })
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextInputState createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _textEditingController.value = TextEditingValue(text: widget.value ?? "");
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
            GestureDetector(
                onTap: widget.onPressBack,
                child: widget.imagePath.endsWith(".png") ||
                        widget.imagePath.endsWith(".jpg")
                    ? Image.asset(
                        widget.imagePath,
                        width: 15.0,
                        height: 15.0,
                      )
                    : SvgPicture.asset(
                        widget.imagePath,
                        width: 15.0,
                        height: 15.0,
                      )),
            const SizedBox(width: 8.0),
            Expanded(
              child: TextField(
                enabled: !widget.isDisabled,
                keyboardType: widget.keyboardType,
                onChanged: (value) {
                  widget.onChangeText(value);
                  _textEditingController.value =
                      _textEditingController.value.copyWith(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                },
                onTap: widget.onClick,
                controller: _textEditingController,
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
                  hintText: widget.hintText,
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
                cursorColor: const Color(0xFF000000),
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            if (widget.additionalImagePath != null)
              Image.asset(
                widget.additionalImagePath!,
                width: 15.0,
                height: 15.0,
              ),
          ],
        ),
      ),
    );
  }
}