import 'package:flutter/material.dart';
import '../../atom/CustomTextInput.dart';

class PersonalDetail extends StatelessWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;

  const PersonalDetail(
      {Key? key, this.firstName, this.lastName, this.email, this.phone})
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
              onChangeText: (String value) {},
              isDisabled: true,
              value: firstName,
            )),
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
                hintText: "Last Name",
                imagePath: "assets/images/svg/profile-line.svg",
                isDisabled: true,
                value: lastName,
                onChangeText: (String value) {})),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomTextInput(
            hintText: phone ?? "",
            imagePath: 'assets/images/disable.png',
            isDisabled: true,
            additionalImagePath: 'assets/images/Password.png',
            onChangeText: (String value) {},
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextInput(
              hintText: "Email",
              imagePath: "assets/images/svg/email.svg",
              onChangeText: (String value) {},
              isDisabled: true,
              value: email,
            )),
      ],
    );
  }
}
