import 'package:flutter/material.dart';
import '../../atom/CustomTextInput.dart';

class PersonalDetail extends StatelessWidget {
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onLastNameChanged;
  final ValueChanged<String> onEmailChanged;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final bool isDisable;

  const PersonalDetail(
      {Key? key,
      required this.onFirstNameChanged,
      required this.onLastNameChanged,
      required this.onEmailChanged,
      required this.isDisable,
      this.firstName,
      this.lastName,
      this.email,
      this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
                hintText: "First Name",
                imagePath: "assets/images/svg/profile.svg",
                onChangeText: isDisable ? (String e) => {} : onFirstNameChanged,
                value: firstName,
                isDisabled: isDisable)),
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
                hintText: "Last Name",
                imagePath: "assets/images/svg/profile-line.svg",
                onChangeText: isDisable ? (String e) => {} : onLastNameChanged,
                value: lastName,
                isDisabled: isDisable)),
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
              hintText: phone ?? "",
              imagePath: 'assets/images/disable.png',
              isDisabled: true,
              additionalImagePath: 'assets/images/Password.png',
              onChangeText: (String value) {},
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
                hintText: "Email",
                imagePath: "assets/images/svg/email.svg",
                onChangeText: isDisable ? (String e) => {} : onEmailChanged,
                value: email,
                isDisabled: isDisable)),
      ],
    );
  }
}